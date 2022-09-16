class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t ".followers"
    @pagy, @users = pagy @user.followers, items: Settings.index.items
    render "users/show_follow"
  end
end
