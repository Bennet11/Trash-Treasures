class WatchlistsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @watchlist = current_user.watchlists.build(post: @post)

    if @watchlist.save
      flash[:notice] = "Added to Watchlist"
      redirect_to @post
    else
      flash[:alert] = "Failed to add to Watchlist"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @watchlist = current_user.watchlists.find_by(post: @post)

    if @watchlist.destroy
      flash[:notice] = "Removed from Watchlist"
      redirect_to @post
    else
      flash[:alert] = "Failed to Remove from Watchlist"
      render :show
    end
  end
end
