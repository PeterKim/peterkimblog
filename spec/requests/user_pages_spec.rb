require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "index" do
    before {
      sign_in FactoryGirl.create(:user) 
      FactoryGirl.create(:user, 
                         name: "Random User One",
                         email: "randone@example.com")
      FactoryGirl.create(:user, 
                         name: "Random User Two",
                         email: "randtwo@example.com")
      visit users_path
    }
    
    it "Should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
    
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li',text: user.name)
        end
      end
    end
  end
  
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
  
  # sign up
  describe "singup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid field values" do
      it "should not create user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with invalid submit" do
      before { click_button submit }
      it { should have_selector('title', text:'Sign up') }
      it { should have_content('error') }
      it { should have_css('div.field_with_errors') }
      it { should have_selector(:xpath, '//div/form') }
    end
    
    describe "with valid field values" do
      before { valid_fill_user_form }

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.first }
      
        it { should have_selector("title",text: user.name) }
        it { should have_selector('div.alert.alert-success',text:'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end
  
  #edit
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit edit_user_path(user) 
    end
    
    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit User") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_error_message('error') }
    end
    
    describe "with valid infomation" do
      before do 
        valid_fill_user_form("Updated User", "updated@gmail.com") 
        click_button "Save changes"
      end
      let(:updated_user) { User.first }
      
      it { should have_selector('title', text: updated_user.name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) } 
      specify { user.reload.name.should == updated_user.name}
      specify { user.reload.email.should == updated_user.email}
    end
  end
end
