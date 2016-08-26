class HomeController < ApplicationController
  def index
    @search = Post.search do
      fulltext params[:search]
    end
    @posts = @search.results
  end

  def about
  end
end
