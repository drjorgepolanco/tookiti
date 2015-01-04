class User < ActiveRecord::Base
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name,  presence: true, length: { maximum: 30 }
	
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 		 presence: true, length: { maximum: 100 },
												 format: { with: VALID_EMAIL }
end
