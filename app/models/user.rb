class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 51}
	#VALID_EMAIL_REGEX = /\A[u0-9]{6}@sberbank.kz\z/i
	validates :email, presence: true, uniqueness: {case_sensitive: false }, length: { maximum: 11} #, format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { minimum: 8 }
end
