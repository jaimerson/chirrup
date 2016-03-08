class NotificationsController < ApplicationController
  before_action :require_login

  def index
    notifications = fetch_notifications
    notifications.update_all(read: true)
    @notifications = notifications
      .to_a
      .map { |n| NotificationDecorator.new(n) }
  end

  private

  def fetch_notifications
    current_user.notifications
      .includes(follower_notification: :follower)
      .order('read, created_at DESC')
      .limit(50)
  end
end
