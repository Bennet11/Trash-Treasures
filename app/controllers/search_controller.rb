class SearchController < ApplicationController
  def index
    if jump = find_jump_target
      redirect_to jump
    else
      flash[:alert] = "No match found"
      redirect_to :back
    end
  end

  private
    def find_jump_target
      Post.find_by(title: params[:keyword]) ||
      User.find_by(name: params[:keyword], email: params[:keyword])
    end
end
