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
    sort_order = params[:sort_order]
    #TODO: finish user_rating sort and overall_rating sort


    #this one works for the vintage oldest-newest / newest-oldest, price low-high / high-low, expert rating high-low / low-high
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

    # User_Rating Sort #think it works, double check later when you have more ratings in
    if user_sort && sort_order == "desc"
        @wines = @wines.sort_by { |wine| wine.user_rating }.reverse
    elsif user_sort && sort_oder == "asc"
        @wines = @wines.sort_by { |wine| wine.user_rating }
    #TODO finish this part of the sort later, to sort by most reviewed
    # elsif user_sort
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
