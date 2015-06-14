class Shop < ActiveRecord::Base

	#attr_accessible :name, :image, :remote_image_url
	validates :name, :site_url, presence: true
	validates :site_url, uniqueness: true

	mount_uploader :image, ImageUploader

	#default_scope { where("published IS NOT NULL") }
	default_scope { where("id IS NOT NULL") }
	scope :men, -> { where(shop_type_men: true) }
	scope :women, -> { where(shop_type_women: true) }
	scope :interior_design, -> { where(shop_type_interior_design: true) }
end
