class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_save { first_name.capitalize! }
	before_save { last_name.capitalize! }
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name,  presence: true, length: { maximum: 30 }
	
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 		 presence: true, length: { minimum: 7, maximum: 100 },
												 format: { with: VALID_EMAIL },
												 uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 8 }

	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		                                              BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
