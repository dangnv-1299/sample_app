class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i(edit update create)
  before_action :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t ".email_message"
    redirect_to root_path
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t(".password_error"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t ".password_changed"
      redirect_to @user
    else
      flash[:error] = t ".change_failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash[:danger] = t ".flash_email"
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".flash_expiration"
    redirect_to new_password_reset_url
  end
end
