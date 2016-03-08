class NotificationsController < ApplicationController
  before_action :require_login

  def index
    @notifications = current_user.notifications
      .includes(follower_notification: :follower)
      .order('read, created_at DESC')
      .limit(50)
      .to_a
      .map { |n| NotificationDecorator.new(n) }
  end
end
