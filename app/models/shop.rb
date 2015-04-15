class Shop < ActiveRecord::Base

	#attr_accessible :name, :image, :remote_image_url
	validates :name, :site_url, presence: true
	validates :site_url, uniqueness: true

	mount_uploader :image, ImageUploader
end
