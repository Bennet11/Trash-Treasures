class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @watchlisted_posts = @user.watchlisted_posts
  end
end
