class User < ApplicationRecord
	attr_accessor :password
	EMAIL_REG = /.+@.+/i 
	validates :username, presence: true, uniqueness: true, length: {in: 3..20}
	validates :email, presence: true, uniqueness: true, format: EMAIL_REG
	validates :password, length: {in: 6..20}, confirmation: true
	# validates_length_of :password,  on: :create
	before_save :encrypt_password
	after_save 	:clear_password
	after_save  :create_profile

	has_one :profile, dependent: :destroy
	has_many :products, dependent: :destroy
	has_many :orders, dependent: :destroy
	has_many :transactions, through: :orders, source: :products


	enum role: [:normal, :admin]


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
		user = User.where("username = ? OR email = ?", username_or_email, username_or_email).first

		if user && user.match_password(login_password)
			return user
		else
			return false
		end
	end

	def match_password(login_password)
		encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end
# use separate authentication table for facebook login
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
		  user.email = auth.info.email if auth.info.email.present?
		  user.provider = auth.provider
		  user.uid = auth.uid
		  user.name = auth.info.name
		  user.oauth_token = auth.credentials.token
		  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		  user.save(validate: false)

		  if user.profile.nil?
		  	user.create_profile(name: auth.info.name)
		  else
		  	user.profile.update(name: auth.info.name)
		  end
		end
	end
end
