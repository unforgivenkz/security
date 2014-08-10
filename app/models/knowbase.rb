class Knowbase < ActiveRecord::Base
	validates :name, presence: true
	validates :keyword, presence: true
	mount_uploader :avatar, IconUploader
	mount_uploader :doc, DocUploader
end
