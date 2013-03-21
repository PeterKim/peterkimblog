class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  
  # users GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # users POST /users
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

  # new_user GET /users/new
  def new
    @user = User.new
    @submitBtnText = "Create my account"
  end
  
  # edit_user GET /user/id/edit
  def edit
    @submitBtnText = "Save changes"
  end
  
  # user GET /user/id
  def show
    @user = User.find(params[:id])
  end
  
  # user PUT /user/id
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # user DELETE /user/id
  def destroy
  end

  private
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def correct_user
    @user = User.find(params[:id])    
    redirect_to root_url unless current_user?(@user)
  end
end
