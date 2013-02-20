class SessionsController < ApplicationController
  def new 
  end
  
  # authenticate user email/pass
  def create 
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = "Invalid emails or password"
      render 'new'
    end
  end
  
  def destory 
  end
end
