class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @user_posts = current_user.posts
  end
end
