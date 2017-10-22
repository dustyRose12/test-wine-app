class PagesController < ApplicationController

  

  def show
    
    show_page = params[:id]

    if show_page == "page_trending"     
      # @wines = Wine.all
      redirect_to '/wines?page_trending=true'

    elsif show_page == "page_wine_of_day"
      # @wines = Wine.last
      redirect_to '/wines?page_wine_of_day=true'

    elsif show_page == "page_best_of"
      # @wines = Wine.first
      redirect_to '/wines?page_best_of=true'
    end

  end

end
