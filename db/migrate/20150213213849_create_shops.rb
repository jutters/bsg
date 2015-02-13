class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :site_url
      t.string :image_url
      t.text :comment

      t.timestamps
    end
  end
end
