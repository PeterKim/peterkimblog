class UsersController < ApplicationController
  def new
    @user = User.new
    @submitLabel = "Create my account"
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Peter's blog!" 
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @submitLabel = "Save changes"
  end
  
  def update
    # put method
  end
end
