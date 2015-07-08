class CreateShopFavorites < ActiveRecord::Migration
  def change
    create_table :shop_favorites do |t|
      t.references :shop, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
