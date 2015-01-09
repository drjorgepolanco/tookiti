class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, PostImageUploader
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 30, minimum: 3 }
  validates :image,   presence: true
  validate  :image_size

  def image_size
  	if image.size > 2.megabytes
  		errors.add(:image, 'the image has to be smaller than 2MB')
  	end
  end
end
