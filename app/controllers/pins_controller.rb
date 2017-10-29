class PinsController < ApplicationController

  def index
    if current_user
      @pins = Pin.where(user_id: current_user)
    else
      flash[:warning] = "Please log in to see Your Cellar"
    end

  end


  def new
    @wines = Wine.all
    @users = User.all
    
    @pin = Pin.new
  end

  def create  

    
    @pin = Pin.new(
                                  user_id: current_user.id,
                                  wine_id: params[:wine_id]                                 
                                  )
    if @pin.save
      flash[:success] = "Wine Successfully Added"
      redirect_to '/cellar'
    else
      @wines = Wine.all
      @users = User.all
      @wine = Wine.find(params[:wine_id])

      @errors = @pin.errors.full_messages
      render "wines/show.html.erb"
    end

  end


  def edit
    @wines = Wine.all
    @users = User.all

    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.assign_attributes(
                                            user_id: params[:user_id],
                                            wine_id: params[:wine_id]
                                            )
    if @pin.save
      flash[:success] = "Pin Successfully Updated"
      redirect_to "/wines/#{wine_id}"
    else
      @wines = Wine.all
      @users = User.all

      @errors = @pin.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    pin = Pin.find(params[:id])
    pin.destroy

    flash[:warning] = "Wine Successfully Removed"
    redirect_to "/cellar"
  end

end
