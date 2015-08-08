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

   def price
   	 if(object.price.present?)
   	 	object.price
   	 else
   	 	0
   	 end
   end

   def brand_name
   	 if(object.brand_name.present?)
   	 	object.brand_name
   	 else
   	 	""
   	 end
   end

    def v_model
   	 if(object.v_model.present?)
   	 	object.v_model
   	 else
   	 	""
   	 end
   end

   def year
   	 if(object.year.present?)
   	 	object.year
   	 else
   	 	""
   	 end
   end

   def fuel_type
   	 if(object.fuel_type.present?)
   	 	object.fuel_type
   	 else
   	 	"Not Specified"
   	 end
   end

end


