class ShopFavorite < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user

  def self.shops(shop_id)
    where("shop_id = ?", shop_id)
  end

  def self.users(user_id)
    where("user_id = ?", user_id)
  end

end
