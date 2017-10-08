class UsersController < ApplicationController

  def new
    render 'new.html.erb'
  end

  def create
    user = User.new(
                              name: params[:name],
                              email: params[:email],
                              username: params[:username],
                              password: params[:password],
                              password_confirmation: params[:password_confirmation],
                              profile_pic: params[:profile_pic]
                                )
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully created an account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password'
      redirect_to '/signup'
    end

  end

  def show
      @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(
                                            name: params[:name],
                                            email: params[:email],
                                            username: params[:username],
                                            password: params[:password],
                                            password_confirmation: params[:password_confirmation],
                                            profile_pic: params[:profile_pic]                       
                                            )
    if @user.save
      flash[:success] = "Profile Successfully Updated"
      redirect_to "/"
    else
      @errors = @user.errors.full_messages
      render "edit.html.erb"
    end
  end

end
