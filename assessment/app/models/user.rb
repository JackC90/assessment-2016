class User < ApplicationRecord
	attr_accessor :password
	EMAIL_REG = /.+@.+/i 
	validates :username, presence: true, uniqueness: true, length: {in: 3..20}
	validates :email, presence: true, uniqueness: true, format: EMAIL_REG
	validates :password, confirmation: true
	validates_length_of :password, in: 6..20, on: :create
	before_save :encrypt_password
	after_save 	:clear_password

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
end
