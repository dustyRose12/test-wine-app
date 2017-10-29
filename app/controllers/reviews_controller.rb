class ReviewsController < ApplicationController

  def new
    @wines = Wine.all
    @users = User.all
    
    @review = Review.new
  end

  def create  
    @wine = Wine.find(params[:wine_id])
    @review = Review.new(user_id: current_user.id, rating:  params[:rating], wine_id: params[:wine_id], description: params[:description])
    if @review.save
        redirect_to "/wines/#{@wine.id}"
    else 
      render "/"
    end
  end

end
