class SessionsController < ApplicationController
  before_action :find_by_email, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember @user
        redirect_back_or @user
      else
        flash[:warning] = t ".activate_fail"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".flash_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def find_by_email
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash[:danger] = t ".find_error"
    redirect_to root_path
  end
end
