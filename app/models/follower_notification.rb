class FollowerNotification < ActiveRecord::Base
  belongs_to :notification
  belongs_to :follower, class_name: 'User'

  validates_presence_of :follower
end
