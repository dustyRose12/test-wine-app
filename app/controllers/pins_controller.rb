class PinsController < ApplicationController

  def index
    if current_user
      @pins = Pin.where(user_id: current_user.id)
    else
      flash[:warning] = "Please log in to see Your Cellar"
    end

    @personal_category_count = PersonalCategory.where(user_id: current_user.id).count

    @first_personal_category = PersonalCategory.where(user_id: current_user.id).first
    
    @all_other_personal_categories = PersonalCategory.where(user_id: current_user.id).all[1..-1]

    @all_personal_categories = PersonalCategory.where(user_id: current_user.id)

   

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

      @errors = @pin.errors.full_messages.last
      flash[:warning] = "#{@errors}"
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
