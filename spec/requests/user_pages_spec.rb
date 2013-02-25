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
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "abc"
        fill_in "Confirmation", with: "abc"
      end
    
      it "should not increase User.count by one" do
        expect { click_button submit }.not_to change(User, :count).by(1)
      end
    end

    # test error messages 
    describe "with invalid submit" do
      before { click_button submit }
      it { should have_selector('title', text:'Sign up') }
      it { should have_content('error') }
      it { should have_css('div.field_with_errors') }
      it { should have_selector(:xpath, '//div/form') }
    end
    
    describe "with valid field values" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "abcdefg"
        fill_in "Confirmation", with: "abcdefg"
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) {User.find_by_email("user@example.com")}
      
        it { should have_selector("title",text: user.name) }
        it { should have_selector('div.alert.alert-success',text:'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end
end
