FactoryGirl.define do
  
  # FactoryGirl.create(:user)
  factory :user do
    sequence(:name) { |n| "Person_#{n}" }
    sequence(:email) { |n| "Person_#{n}@example.com" }
    password "1234567"
    password_confirmation "1234567"
    
    # :admin == user.admin
    factory :admin do
      admin true
    end
  end
  
  # FactoryGirl.create(:micropost)
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
