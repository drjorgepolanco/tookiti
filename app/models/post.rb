class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 40, minimum: 3 }
  validates :image,   presence: true
end
