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
	validates_with ShopValidator

	mount_uploader :image, ImageUploader

  has_many :shop_favorites
  before_destroy :ensure_not_referenced_by_any_shop_favorite

	#default_scope { where("published IS NOT NULL") }
	default_scope { where("id IS NOT NULL") }
	scope :men, -> { where(shop_type_men: true) }
	scope :women, -> { where(shop_type_women: true) }
	scope :interior_design, -> { where(shop_type_interior_design: true) }

public

  def is_user_favorite(user)
    if user == nil
      false;
    else
      self.shop_favorites.users(user.id).count > 0
      #ShopFavorite.users(user.id).shops(self.id).count > 0
    end    
  end

  def get_locale_string()
    if self.locale_de_shop
      return "Deutscher Shop"
    end
    if self.locale_foreign_shop_de_website
      return "Englischsprachiger Shop mit deutscher Website"
    end
    if self.locale_foreign_shop_de_delivery
      return "Englischsprachiger Shop mit Versand nach Deutschland"
    end
  end

  def get_brand_type_string()
    if self.brand_type_single
      return "Shop mit einer Marke"
    end
    if self.brand_type_multi
      return "Shop mit vielen Marken"
    end
  end

private

  # ensure there are no favorites referencing this shop
  def ensure_not_referenced_by_any_shop_favorite
    if shop_favorites.empty?
      return true
    else
      errors.add(:base, "There a some user favorites referencing this shop.")
      return false
    end
  end

end
