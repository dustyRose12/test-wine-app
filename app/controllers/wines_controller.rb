class WinesController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy] 

  require 'ocr_space'
  require 'open-uri'

  add_breadcrumb "Home",  '/'
  # add_breadcrumb "Red Wine", '/?user_wine_type=Red&from_type=true'


  def index
    @wines = Wine.all

    @resource = OcrSpace::Resource.new(apikey: "9c919eb18788957")
    @image = params[:menu_image]
    file = params[:menu_image]
    # @result = @resource.clean_convert file: file

    sort_attribute = params[:sort].present? && params[:sort]
    order_attribute = params[:sort_order].present? && params[:sort_order]
    sort_min = params[:sort_min].present? && params[:sort_min]
    sort_max = params[:sort_max].present? && params[:sort_max]
    search_term = params[:search_term].present? && params[:search_term]


    sort_wine_type = params[:user_wine_type].present? && params[:user_wine_type]
    varietal_sort = params[:user_varietal].present? && params[:user_varietal]
    region_sort = params[:user_region].present? && params[:user_region]
    country_sort = params[:user_country].present? && params[:user_country]
    user_sort = params[:user_sort].present? && params[:user_sort]
    overall_sort = params[:overall_sort].present? && params[:overall_sort]
    sort_order = params[:sort_order].present? && params[:sort_order]
    dropdown_filter = params[:dropdown_filter].present? && params[:dropdown_filter]

    from_type = params[:from_type].present? && params[:from_type]
    from_var = params[:from_var].present? && params[:from_var]
    from_country = params[:from_country].present? && params[:from_country]
    from_region = params[:from_region].present? && params[:from_region]
    from_vintage = params[:from_vintage].present? && params[:from_vintage]
    from_price = params[:from_price].present? && params[:from_price]
    from_exp_rating = params[:from_exp_rating].present? && params[:from_exp_rating]
    from_user_rating = params[:from_user_rating].present? && params[:from_user_rating]
    from_overall_rating = params[:from_overall_rating].present? && params[:from_overall_rating]
    from_search = params[:from_search].present? && params[:from_search]

    from_pages = params[:from_pages].present? && params[:from_pages]

    page_trending = params[:page_trending].present? && params[:page_trending]
    page_wine_of_day = params[:page_wine_of_day].present? && params[:page_wine_of_day]
    page_best_of = params[:page_best_of].present? && params[:page_best_of]


    
#==============================================================
    # this is for the TOP FILTERS (WINE_TYPE start + ratings):
    if sort_wine_type && dropdown_filter && from_type
      if dropdown_filter == 'user_rating_high'
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end

        @wines = @wines.flatten.uniq


        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)

      elsif dropdown_filter == 'expert_rating_high'
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end

        @wines = @wines.flatten.uniq
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse 
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
  

      elsif dropdown_filter == 'overall_rating_high'
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end

        @wines = @wines.flatten.uniq

        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)

      elsif dropdown_filter == 'price_lowest'
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end

        @wines = @wines.flatten.uniq
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest } 
        @wines = @wines.paginate(:page => params[:page], :per_page => 25) 

       elsif dropdown_filter == 'price_highest'
       wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end
        
        @wines = @wines.flatten.uniq
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)

      elsif dropdown_filter == 'most_reviewed'
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )

        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )

        @wines_c = wine_type_wines & country_wines unless varietal_wines.any?
        @wines_r = wine_type_wines & region_wines unless varietal_wines.any?
        @wines_v = wine_type_wines & varietal_wines unless (region_wines.any? or country_wines.any?)
        @wines_vc = wine_type_wines & varietal_wines & country_wines unless region_wines.any? 
        @wines_vr = wine_type_wines & varietal_wines & region_wines unless country_wines.any?
        @wines_nofilter = wine_type_wines if (varietal_wines.empty? && country_wines.empty? && region_wines.empty?)

        @wines = []

        if @wines_c
          @wines = @wines_c
        end
       if @wines_r
          @wines += @wines_r
        end
        if @wines_v
          @wines += @wines_v
        end
        if @wines_vc
          @wines += @wines_vc
        end
        if @wines_vr
          @wines += @wines_vr
        end
        if @wines_nofilter
          @wines += @wines_nofilter
        end

        @wines = @wines.flatten.uniq
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)

      end     
      return @wines
    end

    #==================================================================

# this is for the TOP FILTERS (VARIETAL start + ratings):
    if varietal_sort && dropdown_filter && from_var
      if dropdown_filter == 'user_rating_high'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse

      elsif dropdown_filter == 'overall_rating_high'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        country_wines = Wine.by_country(country_sort)
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = varietal_wines & country_wines unless region_wines.any?
        @wines = varietal_wines & region_wines unless country_wines.any?
        @wines = varietal_wines if (country_wines.empty? && region_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse

      end     
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end
#===================================================================
     # this is for the TOP FILTERS (COUNTRY start + ratings):
    if country_sort && dropdown_filter && from_country
      if dropdown_filter == 'user_rating_high'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = country_wines & wine_type_wines unless varietal_wines.any?
        @wines = country_wines & varietal_wines unless wine_type_wines.any?
        @wines = country_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end     
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end

   #===================================================================
     # this is for the TOP FILTERS (REGION start + ratings):
    if region_sort && dropdown_filter && from_region
      if dropdown_filter == 'user_rating_high'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        @wines = region_wines & wine_type_wines unless varietal_wines.any?
        @wines = region_wines & varietal_wines unless wine_type_wines.any?
        @wines = region_wines if (wine_type_wines.empty? && varietal_wines.empty?)
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end   
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)  
      return @wines
    end

  #===================================================================

# this is for the TOP FILTERS (VINTAGE/PRICE/EXPERT start + ratings):

 if sort_attribute && dropdown_filter && (from_vintage or from_price or from_exp_rating)

        if sort_attribute && sort_min && sort_max && order_attribute
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
        elsif sort_attribute && order_attribute
          sort_wines = @wines.order({sort_attribute => order_attribute})
        elsif sort_attribute
          sort_wines = @wines.order(sort_attribute)
        end

        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)

        @wines = sort_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
        @wines = sort_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
        @wines = sort_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
        @wines = sort_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)
    
     if dropdown_filter == 'user_rating_high'
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
          @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end  
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
  end
   

  #===================================================================
       # this is for the TOP FILTERS (USER RATING start + ratings):

    if user_sort && dropdown_filter && from_user_rating
        if user_sort && sort_order == "desc"
          user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        elsif user_sort && sort_order == "asc"
          user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        elsif user_sort
            user_wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
        end
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)

        @wines = user_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
        @wines = user_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
        @wines = user_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
        @wines = user_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)

      if dropdown_filter == 'user_rating_high'
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
          @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end   
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)  
      return @wines
    end
  #===================================================================

  # this is for the TOP FILTERS (OVERALL RATING start + ratings):

    if overall_sort && dropdown_filter && from_overall_rating
        if overall_sort && sort_order == "desc"
          overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        elsif overall_sort && sort_order == "asc"
          overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        end

        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)

        @wines = overall_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
        @wines = overall_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
        @wines = overall_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
        @wines = overall_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)

      if dropdown_filter == 'user_rating_high'
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
          @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end  
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)   
      return @wines
    end
  #===================================================================

  # this is for the TOP FILTERS (SEARCH BOX start + ratings):

    if search_term && dropdown_filter
       search_wines = Wine.search(search_term)
        
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)

        @wines = search_wines & varietal_wines unless country_wines.any?
        @wines = search_wines & country_wines unless varietal_wines.any?
        @wines = search_wines if (varietal_wines.empty? && country_wines.empty?)

      if dropdown_filter == 'user_rating_high'
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
          @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end   
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)  
      return @wines

    end
  #===================================================================

  # this is for the TOP FILTERS (PAGES start + ratings):

    if from_pages && dropdown_filter
        if page_trending
          pages_wines =  Wine.order(:existing_avg_user_rating_count).last(9)
        elsif page_wine_of_day
          pages_wines =  Wine.order("RANDOM()").take(1)
        elsif page_best_of
          pages_wines =  Wine.where(vintage: 2016).order(:expert_rating).last(25)
        end

        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
        country_wines = Wine.by_country(country_sort)

        @wines = pages_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
        @wines = pages_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
        @wines = pages_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
        @wines = pages_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)

      if dropdown_filter == 'user_rating_high'
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse

      elsif dropdown_filter == 'expert_rating_high'
        @wines = @wines.sort_by { |wine| wine.expert_rating_for_sort }.reverse   

      elsif dropdown_filter == 'overall_rating_high'
          @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse

      elsif dropdown_filter == 'price_lowest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_lowest }

       elsif dropdown_filter == 'price_highest'
        @wines = @wines.sort_by { |wine| wine.price_for_sort_highest }.reverse

      elsif dropdown_filter == 'most_reviewed'
        @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      end    
      
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
      
    end



  
#===================================================================
#===================================================================
#===================================================================


    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal ==> country):
    if sort_wine_type && varietal_sort && country_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)

      @wines =  wine_type_wines & varietal_wines & country_wines

      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
      add_breadcrumb "#{varietal_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_varietal=#{varietal_sort}&from_type=true"
      add_breadcrumb "#{country_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_varietal=#{varietal_sort}&user_country=#{country_sort}&from_type=true"
      return @wines

    end

    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal ==> region):
    if sort_wine_type && varietal_sort && region_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )

      @wines =  wine_type_wines & varietal_wines & region_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
       add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
      add_breadcrumb "#{varietal_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_varietal=#{varietal_sort}&from_type=true"
      add_breadcrumb "#{region_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_varietal=#{varietal_sort}&user_region=#{region_sort}&from_type=true"
      return @wines

    end

    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal):
    if sort_wine_type && varietal_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      @wines = wine_type_wines & varietal_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
      add_breadcrumb "#{varietal_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_varietal=#{varietal_sort}&from_type=true"
      return @wines
    end

      # this is for the SIDEBAR FILTERS (WINE_TYPE ==> country):
    if sort_wine_type && country_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      country_wines = Wine.by_country(country_sort)
      @wines =  wine_type_wines & country_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
      add_breadcrumb "#{country_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_country=#{country_sort}&from_type=true"
      return @wines
    end

      # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> region):
    if sort_wine_type && region_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )
      @wines = wine_type_wines & region_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
      add_breadcrumb "#{region_sort}", "/wines/?user_wine_type=#{sort_wine_type}&user_region=#{region_sort}&from_type=true"
      return @wines
    end

#=========================================


    # this is for the SIDEBAR FILTERS (VARIETAL ==> country):
    if varietal_sort && country_sort && from_var
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)
      @wines = varietal_wines & country_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{varietal_sort}", "/wines/?user_varietal=#{varietal_sort}&from_var=true"
      add_breadcrumb "#{country_sort}", "/wines/?user_varietal=#{varietal_sort}&user_country=#{country_sort}&from_var=true"
      return @wines
    end

      # this is for the SIDEBAR FILTERS (VARIETAL ==> region):
    if varietal_sort && region_sort && from_var
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )
      @wines =  varietal_wines & region_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{varietal_sort}", "/wines/?user_varietal=#{varietal_sort}&from_var=true"
      add_breadcrumb "#{region_sort}", "/wines/?user_varietal=#{varietal_sort}&user_region=#{region_sort}&from_var=true"
      return @wines
    end


  #====================================================

  # this is for the SIDEBAR FILTERS ( COUNTRY ==> wine_type):
    if country_sort && sort_wine_type && from_country
      country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
      country_name = country_wines.first.region.country.name
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      @wines =  wine_type_wines & country_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{country_name}", "/wines/?user_country=#{country_sort}&from_country=true"
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_country=#{country_sort}&user_wine_type=#{sort_wine_type}&from_country=true"
      return @wines
    end

      # this is for the SIDEBAR FILTERS (COUNTRY ==> varietal):
    if country_sort && varietal_sort && from_country
      country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
      country_name = country_wines.first.region.country.name
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
      @wines =  varietal_wines & country_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{country_name}", "/wines/?user_country=#{country_sort}&from_country=true"
      add_breadcrumb "#{varietal_sort}", "/wines/?user_country=#{country_sort}&user_varietal=#{varietal_sort}&from_country=true"
      return @wines
    end

  #====================================================

  # this is for the SIDEBAR FILTERS ( REGION ==> wine_type):
    if region_sort && sort_wine_type && from_region
      region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      @wines =  wine_type_wines & region_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{region_sort}", "/wines/?user_region=#{region_sort}&from_region=true"
      add_breadcrumb "#{sort_wine_type}", "/wines/?user_region=#{region_sort}&user_wine_type=#{sort_wine_type}&from_region=true"
      return @wines
    end

      # this is for the SIDEBAR FILTERS (REGION ==> varietal):
    if region_sort && varietal_sort && from_region
      region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      @wines =  region_wines & varietal_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "#{region_sort}", "/wines/?user_region=#{region_sort}&from_region=true"
      add_breadcrumb "#{varietal_sort}", "/wines/?user_region=#{region_sort}&user_varietal=#{varietal_sort}&from_region=true"
      return @wines
    end

  #====================================================
  # this is for the SIDEBAR FILTERS ( VINTAGE ==> wine_type):

      if sort_attribute && sort_min && sort_max && order_attribute && sort_wine_type && from_vintage
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
           @wines =  sort_wines & wine_type_wines
           @wines = @wines.paginate(:page => params[:page], :per_page => 25)
            add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && sort_wine_type && from_vintage
          sort_wines = @wines.order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && sort_wine_type && from_vintage
          sort_wines = @wines.order(sort_attribute)
          wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      end
# this is for the SIDEBAR FILTERS ( VINTAGE ==> varietal):

       if sort_attribute && sort_min && sort_max && order_attribute && varietal_sort && from_vintage
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && varietal_sort && from_vintage
          sort_wines = @wines.order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines = sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && varietal_sort && from_vintage
          sort_wines = @wines.order(sort_attribute)
          varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      end

  # this is for the SIDEBAR FILTERS ( VINTAGE ==> country):

       if sort_attribute && sort_min && sort_max && order_attribute && country_sort && from_vintage
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
          add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && country_sort && from_vintage
          sort_wines = @wines.order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines = sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && country_sort && from_vintage
          sort_wines = @wines.order(sort_attribute)
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
            add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      end
  
  #====================================================
  # this is for the SIDEBAR FILTERS ( PRICE ==> wine_type):

      if sort_attribute && sort_min && sort_max && order_attribute && sort_wine_type && from_price
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
          add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && sort_wine_type && from_price
          sort_wines = @wines.order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && sort_wine_type && from_price
          sort_wines = @wines.order(sort_attribute)
          wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_wine_type=#{sort_wine_type}&from_#{sort_attribute}=true"
          return @wines
      end
  
# this is for the SIDEBAR FILTERS ( PRICE ==> varietal):

       if sort_attribute && sort_min && sort_max && order_attribute && varietal_sort && from_price
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
          add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && varietal_sort && from_price
          sort_wines = @wines.order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && varietal_sort && from_price
          sort_wines = @wines.order(sort_attribute)
          varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_varietal=#{varietal_sort}&from_#{sort_attribute}=true"
          return @wines
      end

      # this is for the SIDEBAR FILTERS ( PRICE ==> country):
       if sort_attribute && sort_min && sort_max && order_attribute && country_sort && from_price
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
          add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && order_attribute && country_sort && from_price
          sort_wines = @wines.order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines = sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=#{order_attribute}&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      elsif sort_attribute && country_sort && from_price
          sort_wines = @wines.order(sort_attribute)
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "#{sort_attribute.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
            add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_country=#{country_sort}&from_#{sort_attribute}=true"
          return @wines
      end
  
  #====================================================
    # this is for the SIDEBAR FILTERS ( EXPERT ==> wine_type): 

      if sort_attribute && sort_min && sort_max && order_attribute && sort_wine_type && from_exp_rating
           sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && order_attribute && sort_wine_type && from_exp_rating
          sort_wines = @wines.order({sort_attribute => order_attribute})
           wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =  sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&user_wine_type=#{sort_wine_type}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && sort_wine_type && from_exp_rating
          sort_wines = @wines.order(sort_attribute)
          wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
          @wines =   sort_wines & wine_type_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&from_exp_rating=true"
          add_breadcrumb "#{sort_wine_type}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_wine_type=#{sort_wine_type}&from_exp_rating=true"
          return @wines
      end
      # this is for the SIDEBAR FILTERS ( EXPERT ==> varietal):

       if sort_attribute && sort_min && sort_max && order_attribute && varietal_sort && from_exp_rating
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && order_attribute && varietal_sort && from_exp_rating
          sort_wines = @wines.order({sort_attribute => order_attribute})
           varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&user_varietal=#{varietal_sort}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && varietal_sort && from_exp_rating
          sort_wines = @wines.order(sort_attribute)
          varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
          @wines =  sort_wines & varietal_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&from_exp_rating=true"
          add_breadcrumb "#{varietal_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_varietal=#{varietal_sort}&from_exp_rating=true"
          return @wines
      end
     # this is for the SIDEBAR FILTERS ( EXPERT ==> country):
       if sort_attribute && sort_min && sort_max && order_attribute && country_sort && from_exp_rating
          sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
           add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&user_country=#{country_sort}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && order_attribute && country_sort && from_exp_rating
          sort_wines = @wines.order({sort_attribute => order_attribute})
          country_wines = Wine.by_country(country_sort)
          @wines = sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_exp_rating=true"
          add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&user_country=#{country_sort}&from_exp_rating=true"
          return @wines
      elsif sort_attribute && country_sort && from_exp_rating
          sort_wines = @wines.order(sort_attribute)
          country_wines = Wine.by_country(country_sort)
          @wines =  sort_wines & country_wines
          @wines = @wines.paginate(:page => params[:page], :per_page => 25)
          add_breadcrumb "Expert Rating", "/wines/?sort=#{sort_attribute}&from_exp_rating=true"
          add_breadcrumb "#{country_sort}", "/wines/?sort=#{sort_attribute}&sort_min=&sort_max=&sort_order=&user_country=#{country_sort}&from_exp_rating=true"
          return @wines
      end
  
  #====================================================
  # this is for the SIDEBAR FILTERS ( USER RATING ==> wine_type):    

    if user_sort && sort_order == "desc" && sort_wine_type && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        @wines =  user_wines & wine_type_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{sort_wine_type}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_wine_type=#{sort_wine_type}&from_user_rating=true"
        return @wines
    elsif user_sort && sort_order == "asc" && sort_wine_type && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        @wines =  user_wines & wine_type_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{sort_wine_type}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_wine_type=#{sort_wine_type}&from_user_rating=true"
        return @wines
    elsif user_sort && sort_wine_type && from_user_rating
      user_wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      @wines =  user_wines & wine_type_wines
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
       add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&from_user_rating=true"
        add_breadcrumb "#{sort_wine_type}", "/wines/?user_sort=#{user_sort}&user_wine_type=#{sort_wine_type}&from_user_rating=true"
      return @wines
    end

     # this is for the SIDEBAR FILTERS ( USER RATING ==> varietal):    

    if user_sort && sort_order == "desc" && varietal_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  user_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{varietal_sort}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_varietal=#{varietal_sort}&from_user_rating=true"
        return @wines
    elsif user_sort && sort_order == "asc" && varietal_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  user_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{varietal_sort}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_varietal=#{varietal_sort}&from_user_rating=true"
        return @wines
    elsif user_sort && varietal_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  user_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&from_user_rating=true"
        add_breadcrumb "#{varietal_sort}", "/wines/?user_sort=#{user_sort}&user_varietal=#{varietal_sort}&from_user_rating=true"
        return @wines
    end

    # this is for the SIDEBAR FILTERS ( USER RATING ==> country):    

    if user_sort && sort_order == "desc" && country_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        country_wines = Wine.by_country(country_sort)
        @wines =  user_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{country_sort}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_country=#{country_sort}&from_user_rating=true"
        return @wines
    elsif user_sort && sort_order == "asc" && country_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        country_wines = Wine.by_country(country_sort)
        @wines =  user_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        add_breadcrumb "#{country_sort}", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&user_country=#{country_sort}&from_user_rating=true"
        return @wines
    elsif user_sort && country_sort && from_user_rating
        user_wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
        country_wines = Wine.by_country(country_sort)
        @wines =  user_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&from_user_rating=true"
        add_breadcrumb "#{country_sort}", "/wines/?user_sort=#{user_sort}&user_country=#{country_sort}&from_user_rating=true"
        return @wines
    end
 #====================================================
  # this is for the SIDEBAR FILTERS ( OVERALL RATING ==> wine_type):    

    if overall_sort && sort_order == "desc" && sort_wine_type && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
         wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        @wines =  overall_wines & wine_type_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{sort_wine_type}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_wine_type=#{sort_wine_type}&from_overall_rating=true"
         return@wines
    elsif overall_sort && sort_order == "asc" && sort_wine_type && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        @wines =  overall_wines & wine_type_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{sort_wine_type}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_wine_type=#{sort_wine_type}&from_overall_rating=true"
        return @wines
      end

  # this is for the SIDEBAR FILTERS ( OVERALL RATING ==> varietal):    

      if overall_sort && sort_order == "desc" && varietal_sort && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  overall_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{varietal_sort}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_varietal=#{varietal_sort}&from_overall_rating=true"
         return@wines
    elsif overall_sort && sort_order == "asc" && varietal_sort && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  overall_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{varietal_sort}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_varietal=#{varietal_sort}&from_overall_rating=true"
        return @wines
      end

      # this is for the SIDEBAR FILTERS ( OVERALL RATING ==> country):    

      if overall_sort && sort_order == "desc" && country_sort && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        country_wines = Wine.by_country(country_sort)
        @wines =  overall_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{country_sort}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_country=#{country_sort}&from_overall_rating=true"
         return@wines
    elsif overall_sort && sort_order == "asc" && country_sort && from_overall_rating
        overall_wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        country_wines = Wine.by_country(country_sort)
        @wines =  overall_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        add_breadcrumb "#{country_sort}", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&user_country=#{country_sort}&from_overall_rating=true"
        return @wines
      end

#====================================================
  # this is for the SIDEBAR FILTERS ( SEARCH TERM ==> varietal):    

      if search_term && varietal_sort && from_search
        search_wines = Wine.search(search_term)
        varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
        @wines =  search_wines & varietal_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "#{varietal_sort}", "/wines/?search_term=#{search_term}&user_varietal=#{varietal_sort}&from_search=true"
         return@wines
      end

      # this is for the SIDEBAR FILTERS ( SEARCH TERM ==> country):    

      if search_term && country_sort && from_search
        search_wines = Wine.search(search_term)
        country_wines = Wine.by_country(country_sort)
        @wines =  search_wines & country_wines
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "#{country_sort}", "/wines/?search_term=#{search_term}&user_country=#{country_sort}&from_search=true"
         return@wines
      end

 #==========================================================================
  # this is for the SIDEBAR FILTERS ( PAGES ==> wine_type):    

if from_pages && (page_trending or page_wine_of_day or page_best_of)

      page_trending_wines =  Wine.order(:existing_avg_user_rating_count).last(9)
      page_wine_of_day_wines =  Wine.order("RANDOM()").take(1)
      page_best_of_wines =  Wine.where(vintage: 2016).order(:expert_rating).last(25)

      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)

    if page_trending
      @wines = page_trending_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
      @wines = page_trending_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
      @wines = page_trending_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
      @wines = page_trending_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)

      return @wines

    elsif page_wine_of_day
      @wines = page_wine_of_day_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
      @wines = page_wine_of_day_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
      @wines = page_wine_of_day_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)
      @wines = page_wine_of_day_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines

    elsif page_best_of
      @wines = page_best_of_wines & wine_type_wines unless (varietal_wines.any? or country_wines.any?)
      @wines = page_best_of_wines & varietal_wines unless (wine_type_wines.any? or country_wines.any?)
      @wines = page_best_of_wines & country_wines unless (wine_type_wines.any? or varietal_wines.any?)

      @wines = page_best_of_wines if (wine_type_wines.empty? && varietal_wines.empty? && country_wines.empty?)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end

  end
        


#==============================================================================
#==============================================================================

  #this is for regular TOP NAV BAR simple FILTERS:

  #this one works for the VINTAGE oldest-newest / newest-oldest, PRICE low-high / high-low, EXPERT RATING high-low / low-high
    
    if sort_attribute && sort_min && sort_max && order_attribute
      @wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      breadcrumb = "Expert Rating" if sort_attribute ==  "expert_rating"
      sort_attr_name = (breadcrumb || sort_attribute)
      add_breadcrumb "#{sort_attr_name.capitalize}", "/wines/?sort=#{sort_attribute}&sort_min=#{sort_min}&sort_max=#{sort_max}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
      return @wines
    elsif sort_attribute && order_attribute 
      @wines = @wines.order({sort_attribute => order_attribute})
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      breadcrumb = "Expert Rating" if sort_attribute ==  "expert_rating"
      sort_attr_name = (breadcrumb || sort_attribute)
      add_breadcrumb "#{sort_attr_name.capitalize}", "/wines/?sort=#{sort_attribute}&sort_order=#{order_attribute}&from_#{sort_attribute}=true"
      return @wines
    elsif sort_attribute 
      @wines = @wines.order(sort_attribute)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      breadcrumb = "Expert Rating" if sort_attribute ==  "expert_rating"
      sort_attr_name = (breadcrumb || sort_attribute)
      add_breadcrumb "#{sort_attr_name.capitalize}", "/wines/?sort=#{sort_attribute}&from_#{sort_attribute}=true"
      return @wines
    end

  #for wine type
    if sort_wine_type
        @wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "#{sort_wine_type}", "/wines/?user_wine_type=#{sort_wine_type}&from_type=true"
        return @wines
    end
    #this one is for the varietal, i.e, riesling 
    if varietal_sort
      @wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
      @wines = @wines.paginate(:page => params[:page], :per_page => 25) 
       add_breadcrumb "#{varietal_sort}", "/wines/?user_varietal=#{varietal_sort}&from_var=true"
      return @wines
    end

     if country_sort
        @wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        country_name = @wines.first.region.country.name
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "#{country_name}", "/wines/?user_country=#{country_sort}&from_country=true"
        return @wines
    end

      if region_sort
        @wines = Wine.joins(:region).where(regions: { name: region_sort } )
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "#{region_sort}", "/wines/?user_region=#{region_sort}&from_region=true"
        return @wines
    end


    # User_Rating Sort & Overall Rating Sort
    if user_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        return @wines
    elsif user_sort && sort_order == "asc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&sort_order=#{sort_order}&from_user_rating=true"
        return @wines
    elsif user_sort
      @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      add_breadcrumb "User Rating", "/wines/?user_sort=#{user_sort}&from_user_rating=true"
      return @wines
    end

    if overall_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
        add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        return@wines
    elsif overall_sort && sort_order == "asc"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        @wines = @wines.paginate(:page => params[:page], :per_page => 25)
         add_breadcrumb "Overall Rating", "/wines/?overall_sort=#{overall_sort}&sort_order=#{sort_order}&from_overall_rating=true"
        return @wines
    end

    #Search box
    if search_term
      @wines = Wine.search(search_term)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end


    # HOMEPAGE panel PAGES page_trending = params[:page_trending]
    if page_trending
      @wines = Wine.order(:existing_avg_user_rating_count).last(9)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
      #TODO: tack on this part to order the most reviewed 9 ones by order of best reviews: @wines.order(:existing_avg_user_rating). this syntax doesn't work.
    end
    if page_wine_of_day
      @wines = Wine.order("RANDOM()").take(1)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end 
    #TODO check the order that the wines are displayed, should be highest ratings first
     if page_best_of
      @wines = Wine.where(vintage: 2016).order(:expert_rating).last(25)
      @wines = @wines.paginate(:page => params[:page], :per_page => 25)
      return @wines
    end 



  end

  def new
    @producers = Producer.all
    @varietals = Varietal.all
    @region = Region.all
    
    @wine = Wine.new
  end

  def create  

    @wine = Wine.new(
                                  producer_id: params[:producer_id],
                                  name: params[:name],
                                  varietal_id: params[:varietal_id],
                                  vintage: params[:vintage],
                                  region_id: params[:region_id],
                                  price: params[:price],
                                  expert_rating: params[:expert_rating],
                                  alcohol: params[:alcohol],
                                  ml: params[:ml],
                                  description: params[:description]
                                    )
    if @wine.save
      flash[:success] = "Wine Successfully Created"
      redirect_to "/wines/#{@wine.id}"
    else
      @producers = Producer.all
      @varietals = Varietal.all
      @region = Region.all

      @errors = @wine.errors.full_messages
      render 'new.html.erb'
    end

  end

  def show
    @wine = Wine.find(params[:id])
    @errors = []
  end

  def edit
    @producers = Producer.all
    @varietals = Varietal.all
    @region = Region.all

    @wine = Wine.find(params[:id])
  end

  def update
    @wine = Wine.find(params[:id])
    @wine.assign_attributes(
                                            producer_id: params[:producer_id],
                                            name: params[:name],
                                            varietal_id: params[:varietal_id],
                                            vintage: params[:vintage],
                                            region_id: params[:region_id],
                                            price: params[:price],
                                            expert_rating: params[:expert_rating],
                                            alcohol: params[:alcohol],
                                            ml: params[:ml],
                                            description: params[:description]
                                            )
    if @wine.save
      flash[:success] = "Wine Successfully Updated"
      redirect_to "/wines/#{@wine.id}"
    else
      @producers = Producer.all
      @varietals = Varietal.all
      @region = Region.all

      @errors = @wine.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    wine = Wine.find(params[:id])
    wine.destroy

    flash[:warning] = "Wine Successfully Destroyed"
    redirect_to "/wines"
  end

  def random
    wine_id = Wine.all.sample.id
    redirect_to "/wines/#{wine_id}"
  end

  def get_barcode
      if params[:upc].start_with?("0")
        scanned_code = params[:upc]
      else 
        scanned_code = "0#{params[:upc]}"
      end
    
      @wine = Wine.find_by(upc: scanned_code)
     
      if @wine
        flash[:success] = "Here is the Wine you scanned:"
        render json: { id: @wine.id, url: "/wines/#{@wine.id}" }, status: :ok
      else
        flash.now[:danger] = "Wine not found"
        render json: { errors: 'Wine not found' }, status: :bad_request
      end
  end

  def scan_barcode
  end


  #menu image scanner 
  def get_menu
  end

  def scan_menu
  end

  #menu image reader / parser
  def menu_reader
     @resource = OcrSpace::Resource.new(apikey: "9c919eb18788957")
      # @wines = Wine.all

    @result = @resource.clean_convert file: "app/assets/images/ema-menu.jpg"

  end

def test_image
end

def process_image
  @image = params[:menu_image]
  p @image
  @resource = OcrSpace::Resource.new(apikey: "9c919eb18788957")
  file = File.open(@image, 'w')

  open(@image) do |url_file|
    tmp_file.write(url_file.read)
  end

  tmp_file.rewind

  file = tmp_file.read
  @result = @resource.clean_convert url: file
end



end

