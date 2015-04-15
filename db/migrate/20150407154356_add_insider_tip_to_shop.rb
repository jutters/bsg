class AddInsiderTipToShop < ActiveRecord::Migration
  def change
    add_column :shops, :insider_tip, :boolean, default: false
   	Shop.reset_column_information
    Shop.all.each do |s|
      s.update_attribute :insider_tip, false
    end    
  end
end
