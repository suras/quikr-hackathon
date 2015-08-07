class Ads
  
  def self.ads_by_category(cat_id, from, size)
  	url = Api.base_url+Api.ads_by_category+"?categoryId=#{cat_id}&size=#{size}&from=#{from}"
  	ads = Utils.get(url, Api.ads_by_category)
  	ads
  end

end
