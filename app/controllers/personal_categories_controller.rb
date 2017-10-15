class PersonalCategoriesController < ApplicationController

    def index
      if current_user
        @personal_categories = PersonalCategory.where(user_id: current_user)
      else
        flash[:warning] = "Please log in to see Your Cellar Categories"
      end
  end


  def new
    @users = User.all
    
    @personal_category  = PersonalCategory.new
  end

  def create  
    @personal_category = PersonalCategory.new(
                                                                      user_id: current_user.id,
                                                                      name: params[:name]                                 
                                                                      )
    if @personal_category.save
        flash[:success] = "Category Successfully Created"
        redirect_to '/cellar'
    else
      @users = User.all

      @errors = @pin.errors.full_messages
    end

  end


  def edit
    @users = User.all

    @personal_category = PersonalCategory.find(params[:id])
  end

  def update
    @personal_category = PersonalCategory.find(params[:id])
    @personal_category.assign_attributes(
                                            user_id: current_user.id,
                                            name: params[:name]
                                            )
    if @personal_category.save
      flash[:success] = "Category Successfully Updated"
      redirect_to "/cellar"
    else
      @users = User.all

      @errors = @pin.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    personal_category = PersonalCategory.find(params[:id])
    personal_category.destroy

    flash[:warning] = "Category Successfully Removed"
    redirect_to "/cellar"
  end

end
