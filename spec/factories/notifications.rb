FactoryGirl.define do
  factory :notification do
    user
    notification_type :new_follower

    after(:build) do |n|
      n.follower_notification = FollowerNotification
        .create(follower: create(:user))
    end

    trait :read do
      read true
    end

    trait :unread do
      read false
    end
  end
end
