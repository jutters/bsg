class AddPriceSegmentsToShop < ActiveRecord::Migration
  def change
    add_column :shops, :price_segment_low, :boolean, default: false
    add_column :shops, :price_segment_middle, :boolean, default: false
    add_column :shops, :price_segment_high, :boolean, default: false
    Shop.reset_column_information
    Shop.all.each do |s|
      s.update_attribute :price_segment_low, false
      s.update_attribute :price_segment_middle, true
      s.update_attribute :price_segment_high, false
    end
  end
end
