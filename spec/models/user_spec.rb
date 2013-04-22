# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "example", 
                            email: "example@yahoo.com",
                            password: "123456", 
                            password_confirmation: "123456") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  
  it { should be_valid }
  it { should_not be_admin }
  
  #################################################################
  # admin
  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do 
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "with admin attributes set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
      
      it { should be_admin }
      
    end
  end 
  
  #################################################################
  # email validation
  describe "when email is not present" do
    before { @user.email = nil }
    it {should_not be_valid }
  end
 
  describe "testing invalid email addresses" do
    it "should be invalid" do
      addresses = %w[ petergmailcom peter@gmailcom @gmail.com peter@gmail. peter@.com]
      addresses.each do | invalid_email |
        @user.email = invalid_email 
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do 
      dup_user = @user.dup
      dup_user.email = @user.email.upcase
      dup_user.save
    end
    it { should_not be_valid }
  end
 
  describe "testing mixed case email" do
    let(:mixed_case_email) { "PeterKim@yahoo.cOm" }
    it "should downcast email before saving" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end   
  end

  #################################################################
  # name validation
  describe "when name is not present" do
    before { @user.name = nil }
    it {should_not be_valid }
  end
 
  describe "when name too long" do
    before { @user.name = "a"*51 }
    it {should_not be_valid }
  end

  #################################################################
  # password validation
  describe "password should not be blank" do
    before { @user.password = @user.password_confirmation = " "  }
    it { should_not be_valid }
  end
  
  describe "password should match" do 
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "password confirmation should not be nil" do
    before { @user.password_confirmation = "nil" }
    it { should_not be_valid }
  end
  
  describe "password shouldn't be too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end
  
  describe "authenticate returned" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "valid password provided" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "invalid password provided" do
      let(:authenticate_invalid_password) { found_user.authenticate("blah") }
      
      it { should_not == authenticate_invalid_password }
      specify { authenticate_invalid_password.should be_false } 
    end
  end

  #################################################################
  # remember token
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  #################################################################
  # feed
  describe "micropost association" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should be right microposts in right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end
    
    it "should destroy associated microposts" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost| 
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
    
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end
      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end  
  end
end
