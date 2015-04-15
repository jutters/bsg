class AddBrandTypesToShop < ActiveRecord::Migration
  def change
    add_column :shops, :brand_type_single, :boolean, default: false
    add_column :shops, :brand_type_multi, :boolean, default: true
   	Shop.reset_column_information
    Shop.all.each do |s|
      s.update_attribute :brand_type_single, false
      s.update_attribute :brand_type_multi, true
    end
  end
end
