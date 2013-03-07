class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
end
