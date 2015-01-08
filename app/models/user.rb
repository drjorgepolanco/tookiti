class User < ActiveRecord::Base

	attr_accessor :remember_token, :activation_token, :reset_token

	before_save { email.downcase! }
	before_save { first_name.capitalize! }
	before_save { last_name.capitalize! }

	before_create :create_activation_digest

	has_many :posts, dependent: :destroy
	has_secure_password

	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :password, length: { minimum: 8 }, allow_blank: true
	validates :first_name, :last_name, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { minimum: 7, maximum: 100 },
	          format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

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

	def activate
		update_attribute(:activated,    true)
		update_attribute(:activated_at, Time.zone.now)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private

	  def create_activation_digest
	  	self.activation_token  = User.new_token
	  	self.activation_digest = User.digest(activation_token)
	  end

end
