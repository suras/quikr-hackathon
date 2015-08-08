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
     auto.city = a["cityName"].try(:downcase)
     auto.category_id  = params[:categoryId]
     auto.condition  = a["attribute_Condition"]
     auto.fuel_type  = a["attribute_Fuel_Type"].try(:downcase)
     auto.image_count  = a["image_count"]
     auto.images  = format_if_array(a["images"])
     auto.title  = a["title"]
     auto.v_model = a["attribute_Model"].try(:downcase)
     auto.geo_pins = a["geo_pin"]
     auto.ad_type = a["attribute_Ad_Type"]
     auto.locality = format_if_array(a["ad_locality"])
     auto.color = a["attribute_Color"].try(:downcase)
     auto.v_type = a["attribute_Body_Style"]
     auto.quikr_url = a["url"]
     auto.expire_time = a["adExpireTime"]
     auto.brand_name = a["attribute_Brand_name"].try(:downcase)
     auto.save
     ads_array << auto
    end
    ActiveModel::ArraySerializer.new(ads_array).as_json
  end

  def self.format_if_array(a)
    a = ((a.kind_of? Array)? a.join(",") : a)
  end

  def self.get_ads_from_attr(params)
    automobiles = Automobile.where(nil)
    if(params[:price].present? && (params[:price].kind_of? Array))
      price = params[:price]
      automobiles = automobiles.where(price: price[0]..price[1])
    end
    if(params[:kms].present? && (params[:kms].kind_of? Array))
      kms = params[:kms]
      automobiles = automobiles.where(kms: kms[0]..kms[1])
    end
    if(params[:fuel_type].present? && (params[:fuel_type].kind_of? Array))
      fuel_type = params[:fuel_type]
      automobiles = automobiles.where(fuel_type: fuel_type)
    end
    if(params[:brand_name].present? && (params[:brand_name].kind_of? Array))
      brand_name = params[:brand_name]
      automobiles = automobiles.where(brand_name: brand_name)
    end
    if(params[:color].present? && (params[:color].kind_of? Array))
      color = params[:color]
      automobiles = automobiles.where(color: color)
    end
    if(params[:year].present? && (params[:year].kind_of? Array))
      year = params[:year]
      automobiles = automobiles.where(year: year[0]..year[1])
    end
    automobiles = automobiles.limit(10)
    automobiles
  end

end


