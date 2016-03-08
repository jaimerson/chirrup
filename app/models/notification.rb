class Notification < ActiveRecord::Base
  belongs_to :user
  has_one :follower_notification

  validates_presence_of :follower_notification, if: :new_follower?
  validates_presence_of :user

  TYPES = {
    new_follower: 0,
    post_liked: 1
  }.freeze

  enum notification_type: TYPES

end
