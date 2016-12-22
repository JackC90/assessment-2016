class User < ApplicationRecord
	attr_accessor :password
	EMAIL_REG = /.+@.+/i 
	validates :username, presence: true, uniqueness: true, length: {in: 3..20}
	validates :email, presence: true, uniqueness: true, format: EMAIL_REG
	validates :password, confirmation: true
	validates_length_of :password, in: 6..20, on: :create
	before_save :encrypt_password
	after_save 	:clear_password
	after_save  :create_profile

	has_one :profile
	has_many :products
	has_many :orders
	has_many :transactions, through: :orders, source: :products


	enum role: [:normal, :admin, :vendor]

	def encrypt_password
		if self.password.present?
			self.salt = BCrypt::Engine.generate_salt
  			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end

	def self.authenticate(username_or_email="", login_password="")
		if EMAIL_REG.match(username_or_email)
			user = User.find_by(email: username_or_email)
		else
			user = User.find_by(username: username_or_email)
		end

		if user && user.match_password(login_password)
			return user
		else
			return false
		end
	end

	def match_password(login_password)
		encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
		  user.email = auth.info.email if auth.info.email.present?
		  user.provider = auth.provider
		  user.uid = auth.uid
		  user.name = auth.info.name
		  user.oauth_token = auth.credentials.token
		  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		  user.save(validate: false)
		end

		where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
		  user.profile.name = auth.info.name
		end
	end
end
