module Requests
  module SessionHelpers 
    
    def sign_in(user)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      cookies[:remember_token] = user.remember_token
    end
    
    def valid_fill_user_form(name="Peter Kim",email="pdkim85@gmail.com")
      fill_in "Name", with: name
      fill_in "Email", with: email
      fill_in "Password", with: "123456"
      fill_in "Confirmation", with: "123456"
    end
  end
end
