class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :comments, dependent: :destroy
	before_save { self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 51}
	VALID_EMAIL_REGEX = /\A[u0-9]{6}@sberbank.kz\z/i
	VALID_PASSWORD_REGEX = /(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$\z/
	validates :email, presence: true, uniqueness: {case_sensitive: false }#, format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }, :presence => true, :confirmation => true, :if => lambda{ new_record? || !password.nil? }
	apply_simple_captcha
	mount_uploader :avatar, AvatarUploader

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	def feed
    	Micropost.from_users_followed_by(self)
  	end

    def following?(other_user)
      relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
      relationships.find_by(followed_id: other_user.id).destroy!
    end
    

  	private

    	def create_remember_token
      		self.remember_token = User.encrypt(User.new_remember_token)
    	end
end
