class AutomobileSerializer < ActiveModel::Serializer
  attributes :id,  :likes, :price, :year, :created_time, :kms, 
  :city, :category_id, :condition, :fuel_type, :image_count, :brand_name,
   :images, :title, :v_model, :geo_pins, :ad_type, :locality, :color, 
   :v_type, :quikr_url, :expire_time

   def locality
   	 object.locality.split(",")
   end
   
   def images
   	 object.images.split(",")
   end

end


