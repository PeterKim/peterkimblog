module Requests
  module SessionHelpers 
    
    def valid_sign_in(user)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    
    def valid_sign_up(name, email)
      fill_in "Name", with: name
      fill_in "Email", with: email
      fill_in "Password", with: "123456"
      fill_in "Confirmation", with: "123456"
    end
  end
end
