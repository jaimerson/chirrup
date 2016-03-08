class NotificationDecorator < SimpleDelegator
  def follower
    self.follower_notification.follower
  end

  def follower_username
    follower.username
  end
end
