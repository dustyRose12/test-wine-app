class ReviewsController < ApplicationController

  def new
    @wines = Wine.all
    @users = User.all
    
    @review = Review.new
  end

  def create  
    @wine = Wine.find(params[:wine_id])
    @review = Review.new(
                                        user_id: current_user.id, 
                                        rating:  params[:rating], 
                                        wine_id: params[:wine_id], 
                                        description: params[:description])

    if @review.save
        flash[:success] = "Review successfully submitted"
        redirect_to "/wines/#{@wine.id}"
    else 
      @errors = @review.errors.full_messages.last
      flash[:warning] = "#{@errors}"
      redirect_to "/wines/#{@wine.id}"
    end
  end

   def edit
    @wines = Wine.all
    @users = User.all
    
    @review = Review.find(params[:id])
  end

  def update  
    @wine = Wine.find(params[:wine_id])
    @review = Review.find(params[:id])

    @review.assign_attributes(
                                        user_id: current_user.id, 
                                        rating:  params[:rating], 
                                        wine_id: params[:wine_id], 
                                        description: params[:description])
    if @review.save
      flash[:success] = "Review Successfully Updated"
      redirect_to "/wines/#{@wine.id}"
    else 
      @wines = Wine.all
      @users = User.all

      @errors = @review.errors.full_messages.last
      flash[:warning] = "#{@errors}"
      redirect_to "/wines/#{@wine.id}"
    end
  end

   def destroy
    wine = Wine.find(params[:wine_id])
    review = Review.find(params[:id])
    review.destroy

    flash[:warning] = "Review Successfully Deleted"
    redirect_to "/wines/#{wine.id}"
  end

end
