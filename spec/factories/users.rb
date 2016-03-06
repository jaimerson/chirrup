FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :username do |n|
    "johndoe#{n}"
  end

  factory :user do
    username
    email
    password "password"
  end
end
