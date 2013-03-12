class SessionsController < ApplicationController
  def new 
  end
  
  # authenticate user email/pass
  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Invalid emails or password"
      render 'new'
    end
  end
  
  def destory 
    sign_out
    redirect_to root_url
  end
end
