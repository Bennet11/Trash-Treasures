class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @posts = current_user.posts
    @watchlisted_posts = current_user.watchlisted_posts
  end
end
