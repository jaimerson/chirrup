class User < ActiveRecord::Base
  include Clearance::User
  include Gravtastic
  include Notifiable

  notifiers ::ApplicationNotifier
  has_gravatar

  has_many :posts, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :following_relationships,
    class_name: 'Followership',
    foreign_key: :follower_id,
    dependent: :delete_all

  has_many :follower_relationships,
    class_name: 'Followership',
    dependent: :delete_all

  has_many :followers,
    through: :follower_relationships,
    class_name: 'User'

  has_many :following,
    through: :following_relationships,
    class_name: 'User',
    source: :user

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z0-9_]*\z/ }

  def self.authenticate(email_or_username, password)
    if user = User.find_by(username: email_or_username)
      if password.present? && user.authenticated?(password)
        user
      end
    else
      super(email_or_username, password)
    end
  end

  def follow(user)
    unless user.followers.include? self
      user.followers << self
      user.notify(:new_follower, self)
    end
  end

  def following?(user)
    self.following.include? user
  end
end
