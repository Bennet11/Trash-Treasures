class PostsController < ApplicationController

  before_action :set_categories, only: [:new, :edit]

  def show
    @post = Post.find(params[:id])
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Trash and Treasures EPS",
      amount: (@post.price*100)
    }
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed to Create Post"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Post Updated!"
      redirect_to post_path(@post)
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

  def set_categories
    @categories = Category.all
  end

end
