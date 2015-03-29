class Contest < ActiveRecord::Base
  belongs_to :user
  has_many   :challenges
  has_many   :posts, through: :challenges
  default_scope -> { order(created_at: :desc) }
  validates  :user_id, presence: true
  validates  :title,  presence: true, length: { minimum: 3, maximum: 30 }
  validates  :poster, presence: true
end
