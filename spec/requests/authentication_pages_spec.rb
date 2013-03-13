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
      it { should have_link('Users',href: users_path) }
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
    
    # preventing editing without sign-in
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
      
      # /users/index
      describe "visiting the user index" do
        before { visit users_path }
        it { should have_selector('title',text: 'Sign in') }
      end

      describe "after signiin in" do
        # signin manually to make sure that edit before sign-in rediredted
        # user to sign in page
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        it "should have rendered where user wanted to go initially" do 
          page.should have_selector('title', text: /.*[|] Edit user/i) 
        end
      end
    end
    
    # prevent other users to edit someone else's
    describe "for wrong users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:another_user) { 
        FactoryGirl.create(:user, email: 'another@email.com') 
      }
      before { sign_in(user) }
    
      describe "visiting Users#edit" do
        before { visit edit_user_path(another_user) }
        it { should_not have_selector('h1',text: 'Update your profile')  }
        it { should_not have_selector('title', text: /.*[|] Edit user/i) }
      end
      
      describe "updating another user" do
        before { put user_path(another_user) }
        specify { response.should redirect_to(root_path) }
      end     
    end
  end 
end
