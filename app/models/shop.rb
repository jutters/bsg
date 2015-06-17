class ShopValidator < ActiveModel::Validator
  def validate(record)
  	shop_types = 0;
  	shop_types += 1 if record.shop_type_men_fashion?;
  	shop_types += 1 if record.shop_type_women_fashion?;
  	shop_types += 1 if record.shop_type_interior_design?;
  	if shop_types == 0
  		record.errors[:base] << "Shop must be assigned at least one shop type";
  	end

  	price_segments = 0;
  	price_segments += 1 if record.price_segment_low?;
  	price_segments += 1 if record.price_segment_middle?;
	price_segments += 1 if record.price_segment_high?;
  	if price_segments == 0
  		record.errors[:base] << "Shop must be assigned at least one price segment";
  	end

  	locales = 0;
  	locales += 1 if record.locale_de_shop?;
  	locales += 1 if record.locale_foreign_shop_de_website?;
  	locales += 1 if record.locale_foreign_shop_de_delivery?;
  	if locales != 1
  		record.errors[:base] << "Shop must be assigned exactly one locale";
  	end

  	brand_types = 0;
  	brand_types += 1 if record.brand_type_single?;
  	brand_types += 1 if record.brand_type_multi?;
  	if brand_types != 1
  		record.errors[:base] << "Shop must be assigned exactly one brand type"
  	end

  	if record.image_url.blank?
  		record.errors[:base] << "Missing image"
  	end 
  end
end

class Shop < ActiveRecord::Base

	#attr_accessible :name, :image, :remote_image_url
	validates :name, :site_url, presence: true
	validates :site_url, uniqueness: true
	validates_with ShopValidator

	mount_uploader :image, ImageUploader

	#default_scope { where("published IS NOT NULL") }
	default_scope { where("id IS NOT NULL") }
	scope :men, -> { where(shop_type_men: true) }
	scope :women, -> { where(shop_type_women: true) }
	scope :interior_design, -> { where(shop_type_interior_design: true) }
end
