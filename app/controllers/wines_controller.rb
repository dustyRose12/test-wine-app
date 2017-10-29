class WinesController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy] 

  def index
    @wines = Wine.all

    sort_attribute = params[:sort]
    order_attribute = params[:sort_order]
    sort_min = params[:sort_min]
    sort_max = params[:sort_max]
    search_term = params[:search_term]

    sort_wine_type = params[:user_wine_type]
    varietal_sort = params[:user_varietal]
    region_sort = params[:user_region]
    country_sort = params[:user_country]
    user_sort = params[:user_sort]
    overall_sort = params[:overall_sort]
    sort_order = params[:sort_order]

    page_trending = params[:page_trending]
    page_wine_of_day = params[:page_wine_of_day]
    page_best_of = params[:page_best_of]
    #TODO: finish user_rating sort and overall_rating sort


    #this one works for the VINTAGE oldest-newest / newest-oldest, PRICE low-high / high-low, EXPERT RATING high-low / low-high
    if sort_attribute && sort_min && sort_max && order_attribute
      @wines = Wine.where({sort_attribute => sort_min..sort_max}).order({sort_attribute => order_attribute})
    elsif sort_attribute && order_attribute 
      @wines = @wines.order({sort_attribute => order_attribute})
    elsif sort_attribute 
      @wines = @wines.order(sort_attribute)
    end

    #this one is for the type of wine, i.e, red or white
    if sort_wine_type
        @wines = Wine.joins(:varietal).where(varietals: { wine_type: sort_wine_type } )
    end

    #this one is for the varietal, i.e, riesling 
    if varietal_sort
      @wines = Wine.joins(:varietal).where(varietals: { name: varietal_sort } ) 
    end

     if country_sort
        @wines = Wine.includes(:region).where(regions: { country_id: country_sort } )
    end

      if region_sort
        @wines = Wine.joins(:region).where(regions: { name: region_sort } )
    end

    #Search box
    if search_term
      p "SEARCH"
      @wines = Wine.search(search_term)
      p @wines    
    end

    # User_Rating Sort
    if user_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }.reverse
    elsif user_sort && sort_order == "asc"
        @wines = @wines.sort_by { |wine| wine.user_rating_for_sort }
    elsif user_sort
      @wines = @wines.sort_by { |wine| wine.user_rating_count}.reverse
    end

     # Overall_Rating Sort DOESN'T WORK
    if overall_sort && sort_order == "desc"
      p "OVERALL SORT DESC"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
    elsif overall_sort && sort_order == "asc"
      p "OVERALL SORT ASC"
        @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }
     # MAYBE DO later, if have time: add sorting ranges 5-4, 4-3, < 3   
    # elsif overall_sort && sort_order == "5 - 4"
    #   @wines = @wines.sort_by { |wine| wine.overall_rating_for_sort }.reverse
    end



    # page_trending = params[:page_trending]
    if page_trending
      @wines = Wine.order(:existing_avg_user_rating_count).last(9)
      #TODO: tack on this part to order the most reviewed 9 ones by order of best reviews: @wines.order(:existing_avg_user_rating). this syntax doesn't work.
    end
    if page_wine_of_day
      @wines = Wine.order("RANDOM()").take(1)
    end 
    #TODO check the order that the wines are displayed, should be highest ratings first
     if page_best_of
      @wines = Wine.where(vintage: 2016).order(:expert_rating).last(9)
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
