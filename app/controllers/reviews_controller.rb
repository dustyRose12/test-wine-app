class ReviewsController < ApplicationController

  def new
    @wines = Wine.all
    @users = User.all
    
    @review = Review.new
  end

  def create  
    @wine = Wine.find(params[:wine_id])
    @review = Review.new(user_id: current_user.id, rating:  params[:rating], wine_id: params[:wine_id])
    if @review.save
        redirect_to "/"
    else 
      render "/wines/#{@wine.id}"
    end
    # @review = Pin.new(
    #                               user_id: current_user.id,
    #                               wine_id: params[:wine_id]                                 
    #                               )
    # if @pin.save
    #   flash[:success] = "Wine Successfully Pinned"
    #   redirect_to '/cellar'
    # else
    #   @wines = Wine.all
    #   @users = User.all

    #   @errors = @pin.errors.full_messages
    # end

  end
end
