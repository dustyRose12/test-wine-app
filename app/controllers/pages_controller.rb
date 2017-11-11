class PagesController < ApplicationController

  
  def show
    
    show_page = params[:id]

    if show_page == "page_trending"     
      redirect_to '/wines?page_trending=true&from_pages=true'

    elsif show_page == "page_wine_of_day"
      redirect_to '/wines?page_wine_of_day=true&from_pages=true'

    elsif show_page == "page_best_of"
      redirect_to '/wines?page_best_of=true&from_pages=true'
    end

    regions = ["Bordeaux", "California", "Marlborough", "Mendoza", "Mosel", "Rioja", "Tuscany"]

    regions.each do |region|
      if show_page == region.downcase
        @page = region
      end
    end
   
  end

end
