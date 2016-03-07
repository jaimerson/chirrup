class User < ActiveRecord::Base
  include Clearance::User
  include Gravtastic

  has_gravatar

  has_many :posts, dependent: :destroy

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
end
