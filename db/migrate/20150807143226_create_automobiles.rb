class CreateAutomobiles < ActiveRecord::Migration
  def change
    create_table :automobiles do |t|
      t.integer :likes
      t.integer :price
      t.integer :year
      t.integer :created_time
      t.integer :kms
      t.string :city
      t.integer :category_id
      t.string :condition
      t.string :fuel_type
      t.integer :image_count
      t.string :brand_name
      t.string :images
      t.string :title
      t.string :v_model
      t.string :geo_pins
      t.string :ad_type
      t.string :locality
      t.string :color
      t.string :car_type
      t.string :quikr_url
      t.integer :expire_time

      t.timestamps null: false
    end
  end
end
