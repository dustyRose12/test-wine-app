class WinesController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy] 

  def index
    @wines = Wine.all

    sort_attribute = params[:sort]
    order_attribute = params[:sort_order]
    sort_min = params[:sort_min]
    sort_max = params[:sort_max]
    search_term = params[:search_term]

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


    user_wine_type_from_v = params[:user_wine_type_from_v].present? && params[:user_wine_type_from_v]


    page_trending = params[:page_trending]
    page_wine_of_day = params[:page_wine_of_day]
    page_best_of = params[:page_best_of]


    #this one works for the VINTAGE oldest-newest / newest-oldest, PRICE low-high / high-low, EXPERT RATING high-low / low-high
    if sort_attribute && sort_min && sort_max && order_attribute
      @wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
      return @wines
    elsif sort_attribute && order_attribute 
      @wines = @wines.order({sort_attribute => order_attribute})
      return @wines
    elsif sort_attribute 
      @wines = @wines.order(sort_attribute)
      return @wines
    end
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
      return @wines
    end

    # #this one is for the type of wine, i.e, red or white
    # if sort_wine_type
    #     @wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
    #     return @wines
    # end

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
      return @wines
    end

  #===================================================================

    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal ==> country):
    if sort_wine_type && varietal_sort && country_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)

      @wines =  wine_type_wines & varietal_wines & country_wines
      return @wines

    end

    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal ==> region):
    if sort_wine_type && varietal_sort && region_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )

      @wines =  wine_type_wines & varietal_wines & region_wines
      return @wines

    end

    # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> varietal):
    if sort_wine_type && varietal_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      @wines = wine_type_wines & varietal_wines
      return @wines
    end

      # this is for the SIDEBAR FILTERS (WINE_TYPE ==> country):
    if sort_wine_type && country_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      country_wines = Wine.by_country(country_sort)
      @wines =  wine_type_wines & country_wines
      return @wines
    end

      # this is for the SIDEBAR FILTERS ( WINE_TYPE ==> region):
    if sort_wine_type && region_sort && from_type
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )
      @wines = wine_type_wines & region_wines
      return @wines
    end

#=========================================


    # HAVENT DONE just this one: this is for the SIDEBAR FILTERS (VARIETAL ==> country ==> region):
    if varietal_sort && country_sort && region_sort && from_var
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )

      @wines =  varietal_wines & country_wines & region_wines
      return @wines

    end

    # this is for the SIDEBAR FILTERS (VARIETAL ==> country):
    if varietal_sort && country_sort && from_var
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      country_wines = Wine.by_country(country_sort)
      @wines = varietal_wines & country_wines
      return @wines
    end

      # this is for the SIDEBAR FILTERS (VARIETAL ==> region):
    if varietal_sort && region_sort && from_var
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      region_wines = Wine.joins(:region).where("regions.name iLIKE ?", "%#{region_sort}%" )
      @wines =  varietal_wines & region_wines
      return @wines
    end


  #====================================================

  # this is for the SIDEBAR COMBO FILTERS ( COUNTRY ==> wine_type):
    if country_sort && sort_wine_type && from_country
      country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      @wines =  wine_type_wines & country_wines
      return @wines
    end

      # this is for the SIDEBAR COMBO FILTERS (COUNTRY ==> varietal):
    if country_sort && varietal_sort && from_country
      country_wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } )
      @wines =  varietal_wines & country_wines
      return @wines
    end

  #====================================================

  # this is for the SIDEBAR COMBO FILTERS ( REGION ==> wine_type):
    if region_sort && sort_wine_type && from_region
      region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
      @wines =  wine_type_wines & region_wines
      return @wines
    end

      # this is for the SIDEBAR COMBO FILTERS (REGION ==> varietal):
    if region_sort && varietal_sort && from_region
      region_wines = Wine.joins(:region).where(regions: { name: region_sort } )
      varietal_wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      @wines =  region_wines & varietal_wines
      return @wines
    end

  #====================================================
  # this is for the SIDEBAR COMBO FILTERS ( VINTAGE - WINE TYPE):
    if user_wine_type_from_v && sort_attribute && sort_min && sort_max && sort_order 

      if sort_attribute && sort_min && sort_max && order_attribute
      sort_wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
      elsif sort_attribute && order_attribute 
        sort_wines = @wines.order({sort_attribute => order_attribute})
      elsif sort_attribute 
        sort_wines = @wines.order(sort_attribute)
      end

      wine_type_wines = Wine.joins(:varietal).where(varietals: { wine_type: user_wine_type_from_v } )
      @wines =  wine_type_wines & sort_wines
      p sort_wines
      return @wines
    end
  #====================================================


  #this is for regular TOP NAV BAR simple FILTERS:

    if sort_wine_type
        @wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
        return @wines
    end
    #this one is for the varietal, i.e, riesling 
    if varietal_sort
      @wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
      return @wines
    end

     if country_sort
        @wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
        return @wines
    end

      if region_sort
        @wines = Wine.joins(:region).where(regions: { name: region_sort } )
        return @wines
    end

    #Search box
    if search_term
      @wines = Wine.search(search_term)
      return @wines
    end

    # User_Rating Sort
    if user_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
        return @wines
    elsif user_sort && sort_order == "asc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
        return @wines
    elsif user_sort
      @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
      return @wines
    end

    if overall_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
        return@wines
    elsif overall_sort && sort_order == "asc"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
        return @wines
     # MAYBE DO later, if have time: add sorting ranges 5-4, 4-3, < 3   
    # elsif overall_sort && sort_order == "5 - 4"
    #   @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
    end



    # HOMEPAGE panel PAGES page_trending = params[:page_trending]
    if page_trending
      @wines = Wine.order(:existing_avg_user_rating_count).last(9)
      return @wines
      #TODO: tack on this part to order the most reviewed 9 ones by order of best reviews: @wines.order(:existing_avg_user_rating). this syntax doesn't work.
    end
    if page_wine_of_day
      @wines = Wine.order("RANDOM()").take(1)
      return @wines
    end 
    #TODO check the order that the wines are displayed, should be highest ratings first
     if page_best_of
      @wines = Wine.where(vintage: 2016).order(:expert_rating).last(9)
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

    @purse = Purse.find(params[:id])
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
    wine_id = Purse.all.sample.id
    redirect_to "/wines/#{wine_id}"
  end

  def get_barcode
      @wine = Wine.find_by(upc: params[:upc])
     
      if @wine
        render json: { id: @wine.id, url: "/wines/#{@wine.id}" }
      else
        flash[:danger] = "Wine not found"
        render json: { errors: 'Wine not found' }
      end
  end

  def scan_barcode
  end


  # could potentially use this later
  # def pin
  #   type = params[:type]
  #   if type == "pinned"
  #     current_user.pins << @wine
  #     redirect_to :back, notice: 'You pinned this wine'

  #   elsif type == "unpinned"
  #     current_user.pins.delete(@wine)
  #     redirect_to :back, notice: 'You unpinned this wine'

  #   else
  #     # Type missing, nothing happens
  #     redirect_to :back, notice: 'Nothing happened.'
  #   end
  # end



end

