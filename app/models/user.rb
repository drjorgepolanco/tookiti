class User < ActiveRecord::Base
	before_save { email.downcase! }
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name,  presence: true, length: { maximum: 30 }
	
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 		 presence: true, length: { minimum: 7, maximum: 100 },
												 format: { with: VALID_EMAIL },
												 uniqueness: { case_sensitive: false }
	has_secure_password
end
