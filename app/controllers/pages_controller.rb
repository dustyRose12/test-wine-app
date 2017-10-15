class PagesController < ApplicationController

  def show
    
    show_page = params[:id]

    if show_page = "trending"
      @wines = Wine.all
    elsif show_page = "wineofday"
      @wines = Wine.last
    elsif show_page = "bestof2016"
      @wines = Wine.first
    end

  end

end
