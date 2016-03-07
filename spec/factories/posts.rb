FactoryGirl.define do
  factory :post do
    user
    sequence(:content) do |n|
      "Exorcisamus te lorem ipsum dolor sit amet consectetur #{n} times"
    end

    trait :with_parent do
      association :parent, factory: :post
    end
  end
end
