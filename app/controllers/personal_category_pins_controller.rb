class PersonalCategoryPinsController < ApplicationController

  def index
 
  end


  def new
    @pins = Pin.all
    @personal_categories = PersonalCategory.all
    
    @personal_category_pin  = PersonalCategoryPin.new
  end

  def create  
    @personal_category_pin = PersonalCategoryPin.create(
                                                                      pin_id: params[:pin_id],
                                                                      personal_category_id: params[:personal_category_id]
                                                                      )
    p "ERRORS"
    p @personal_category_pin.errors.full_messages
    redirect_to "/cellar"


  end


  def edit
    @pins = Pin.all
    @personal_categories = PersonalCategory.all

    @personal_category_pin = PersonalCategoryPin.find(params[:id])
  end

  def update
    @personal_category_pin = PersonalCategoryPin.find(params[:id])
    @personal_category_pin.assign_attributes(
                                            pin_id: params[:pin_id],
                                            personal_category_id: params[:personal_category_id]
                                            )
      redirect_to "/cellar"

  end

  def destroy
    personal_category_pin = PersonalCategoryPin.find(params[:id])
    personal_category_pin.destroy

    redirect_to "/cellar"
  end

end
