class PostsController < ApplicationController

  before_filter :prepare_categories

  def show
    @post = Post.find(params[:id])
    @users = User.all
    @user = current_user
    @location = @post.user.location
    @category = @post.category
    @id = @post.user
    @owner = @post.owner
    @amount = @post.price
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Trash and Treasures EPS",
      amount: (@post.price*100)
    }
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user


    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to post_path(@post, @user)
    else
      flash[:alert] = "Failed to Create Post"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    authorize @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Post Updated!"
      redirect_to post_path(@post, @user)
    else
      flash[:notice] = "Failed to update post"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "Post deleted!"
      redirect_to home_index_path
    else
      flash[:alert] = "Failed to delete post"
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :number, :price, :image, :category_id)
  end

  def prepare_categories
    @categories = Category.all
  end
end
