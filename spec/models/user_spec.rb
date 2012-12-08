require 'spec_helper'

describe User do
  before { @user = User.new(name:"example",email:"example@yahoo.com") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = nil }
    it {should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = nil }
    it {should_not be_valid }
  end
  
  describe "when name too long" do
    before { @user.name = "a"*51 }
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
end
