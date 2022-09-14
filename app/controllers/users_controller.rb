class UsersController < ApplicationController
  before_action :logged_in_user,
                except: %i(new create)
  before_action :find_user,
                except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @pagy, @users = pagy(User.order(name: :asc))
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".flash_info"
      redirect_to root_path
    else
      flash.now[:danger] = t ".alert_not_save"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t ".flash_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(User::UPDATABLE_ATTRS)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".flash_login"
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t ".correct_user"
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t ".admin_user"
    redirect_to root_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".find_user"
    redirect_to root_path
  end
end
