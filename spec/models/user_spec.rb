# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name:"example", email:"example@yahoo.com", password: "1234", password_confirmation: "1234") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
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
  
  describe "when email address is already taken" do
    before do 
      dup_user = @user.dup
      dup_user.email = @user.email.upcase
      dup_user.save
    end
    it { should_not be_valid }
  end
  
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
end
