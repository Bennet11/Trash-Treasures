class HomeController < ApplicationController
  def index
    # @search = Post.search do
    #   fulltext params[:search]
    # end
    # @posts = @search.results
    @posts = Post.all.limit(5)
  end

  def about
  end
end
