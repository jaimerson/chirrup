class ApplicationNotifier
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def notify(notification_type, *args)
    NotificationBuilder.new(user)
      .create_notification(notification_type, *args)
  end
end
