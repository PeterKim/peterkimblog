require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }
  
  # sign in
  describe "signin page" do 
        
    describe "with invalid information" do
      before { 
        visit signin_path
        click_button "Sign in"  
      }
    
      it { should have_selector('title', text: 'Sign in') }
      it { should have_error_message('Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in(user) }
      
      it { should have_selector('title',text: user.name) }
      it { should have_link('Profile',href: user_path(user)) }
      it { should have_link('Settings',href: edit_user_path(user)) }
      it { should have_link('Sign out',href: signout_path) }
      it { should_not have_link('Sign in',href: signin_path) }      
      
      describe "followed by sign-out" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
  
  # authorization
  describe "authorization" do
    describe "for non-signin user" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_selector('title', text: 'Sign in') }
      end
      
      describe "submitting to update action" do
        before { put user_path(user) } 
        specify { response.should redirect_to(signin_path) }
      end
     
    end
  end 
end
