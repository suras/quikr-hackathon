class Automobile < ActiveRecord::Base
 
  def self.get_ads(params)
   	url = Api.base_url+Api.ads_by_category+"?categoryId=#{params[:categoryId]}"+
           "&size=#{params[:size]}&from=#{params[:from]}"+
   	       "&city=#{params[:city]}"
   	ads = Utils.get(url, Api.ads_by_category)
    begin
   	  self.save_and_get_ads(ads["AdsByCategoryResponse"]["AdsByCategoryData"]["docs"], params)
    rescue => e
      []
    end
  end

  def self.save_and_get_ads(ads, params)
    ads_array = Array.new
    ads.each do |a|
    	auto = Automobile.where(id: a["id"]).first_or_initialize
    	auto.id = a["id"]
    	auto.price = a["attribute_Price"]
    	auto.year = a["year"]
     auto.created_time = a["createdTime"]
     auto.kms  = a["kms_Driven"]
     auto.city = a["cityName"]
     auto.category_id  = params[:categoryId]
     auto.condition  = a["attribute_Condition"]
     auto.fuel_type  = a["attribute_Fuel_Type"]
     auto.image_count  = a["image_count"]
     auto.images  = format_if_array(a["images"])
     auto.title  = a["title"]
     auto.v_model = a["attribute_Model"]
     auto.geo_pins = a["geo_pin"]
     auto.ad_type = a["attribute_Ad_Type"]
     auto.locality = format_if_array(a["ad_locality"])
     auto.color = a["attribute_Color"]
     auto.v_type = a["attribute_Body_Style"]
     auto.quikr_url = a["url"]
     auto.expire_time = a["adExpireTime"]
     auto.brand_name = a["attribute_Brand_name"]
     auto.save
     ads_array << auto
    end
    ActiveModel::ArraySerializer.new(ads_array).as_json
  end

  def self.format_if_array(a)
    a = ((a.kind_of? Array)? a.join(",") : a)
  end

end


