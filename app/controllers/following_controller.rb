class FollowingController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t ".following"
    @pagy, @users = pagy @user.following, items: Settings.index.items
    render "users/show_follow"
  end
end
