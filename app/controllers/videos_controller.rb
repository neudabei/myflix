class VideosController < ApplicationController
 
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find_by(id: params[:id])
  end

  def search
    search_term = Video.search_by_term(params[:q])
  end

end