class ChangeDefaultValuesOfShops < ActiveRecord::Migration
  def change
	change_column :shops, :price_segment_low, :boolean , default: false
	change_column :shops, :price_segment_middle, :boolean , default: false
	change_column :shops, :price_segment_high, :boolean , default: false
	change_column :shops, :locale_de_shop, :boolean , default: false
	change_column :shops, :locale_foreign_shop_de_website, :boolean , default: false
	change_column :shops, :locale_foreign_shop_de_delivery, :boolean , default: false
	change_column :shops, :brand_type_single, :boolean , default: false
	change_column :shops, :brand_type_multi, :boolean , default: false
	change_column :shops, :shop_type_women_fashion, :boolean , default: false
	change_column :shops, :shop_type_men_fashion, :boolean , default: false
	change_column :shops, :shop_type_interior_design, :boolean , default: false
	change_column :shops, :insider_tip, :boolean , default: false
  end
end
