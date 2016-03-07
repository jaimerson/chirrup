FactoryGirl.define do
  factory :post do
    user
    content 'Exorcisamus te lorem ipsum dolor sit amet consectetur'

    trait :with_parent do
      association :parent, factory: :post
    end
  end
end
