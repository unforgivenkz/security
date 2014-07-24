class Comment < ActiveRecord::Base
	validates :user_id, presence: true
	validates :micropost_id, presence: true
	belongs_to :micropost
	validates :content, presence: true, length: { maximum: 300 }
end

