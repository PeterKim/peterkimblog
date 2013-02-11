require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "singup" do
  
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid field values" do
      it "should not create user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with invalid password values" do
      before do
        fill_in "Name", with:"Example User"
        fill_in "Email", with:"user@example.com"
        fill_in "Password", with:"abc"
        fill_in "Password_confirmation", with:"abc"
      end
    
      it "should increase User.count by one" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe "with valid field values" do
      before do
        fill_in "Name", with:"Example User"
        fill_in "Email", with:"user@example.com"
        fill_in "Password", with:"abcdefg"
        fill_in "Password_confirmation", with:"abcdefg"
      end
    
      it "should increase User.count by one" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
