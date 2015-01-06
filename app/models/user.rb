class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token
	before_save { email.downcase! }
	before_save { first_name.capitalize! }
	before_save { last_name.capitalize! }
	before_create :create_activation_digest
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name,  presence: true, length: { maximum: 30 }
	
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 		 presence: true, length: { minimum: 7, maximum: 100 },
												 format: { with: VALID_EMAIL },
												 uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 8 }, allow_blank: true

	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		                                              BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	private

		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

end
