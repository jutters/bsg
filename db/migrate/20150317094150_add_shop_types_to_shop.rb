class AddShopTypesToShop < ActiveRecord::Migration
  def change
    add_column :shops, :shop_type_women_fashion, :boolean, default: false
    add_column :shops, :shop_type_men_fashion, :boolean, default: false
    add_column :shops, :shop_type_interior_design, :boolean, default: false
   	Shop.reset_column_information
    Shop.all.each do |s|
      s.update_attribute :shop_type_women_fashion, true
      s.update_attribute :shop_type_men_fashion, true
      s.update_attribute :shop_type_interior_design, false
    end    
  end
end
