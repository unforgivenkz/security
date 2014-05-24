class User < ActiveRecord::Base
	before_save { self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 51}
	VALID_EMAIL_REGEX = /\A[u0-9]{6}@sberbank.kz\z/i
	VALID_PASSWORD_REGEX = /(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$\z/
	validates :email, presence: true, uniqueness: {case_sensitive: false }#, format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

    	def create_remember_token
      		self.remember_token = User.encrypt(User.new_remember_token)
    	end
end
