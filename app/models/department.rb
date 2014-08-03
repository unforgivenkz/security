class Department < ActiveRecord::Base
	validates :name1, presence: true, length: { maximum: 51}
	validates :name2, presence: true, length: { maximum: 51}
	validates :name3, presence: true, length: { maximum: 51}
end
