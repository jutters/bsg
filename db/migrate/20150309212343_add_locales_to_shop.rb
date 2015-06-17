class AddLocalesToShop < ActiveRecord::Migration
  def change
    add_column :shops, :locale_de_shop, :boolean, default: false
    add_column :shops, :locale_foreign_shop_de_website, :boolean, default: false
    add_column :shops, :locale_foreign_shop_de_delivery, :boolean, default: false
   	Shop.reset_column_information
    Shop.all.each do |s|
      s.update_attribute :locale_de_shop, true
      s.update_attribute :locale_foreign_shop_de_website, false
      s.update_attribute :locale_foreign_shop_de_delivery, false
    end
  end
end
