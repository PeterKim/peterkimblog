FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person_#{n}" }
    sequence(:email) { |n| "Person_#{n}@example.com" }
    password "1234567"
    password_confirmation "1234567"
  end
end
