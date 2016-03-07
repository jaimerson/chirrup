class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class_name: 'Post'
  has_many :children, class_name: 'Post', foreign_key: :parent_id

  validates :content,
    presence: true,
    length: { maximum: 160 }

  validates_presence_of :user
  delegate :username, to: :user
end
