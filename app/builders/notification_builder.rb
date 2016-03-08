class NotificationBuilder
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_notification(type, *args)
    Notification.transaction do
      notification = user.notifications.build(notification_type: type)
      block = method(type)
      block.call(notification, *args)
      notification.save!
    end
  end

  private

  def new_follower(notification, follower)
    notification.follower_notification = FollowerNotification
      .create!(follower: follower)
  end
end
