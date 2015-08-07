class Ads
  
  def self.ads_by_category(params)
  	url = Api.base_url+Api.ads_by_category+"?categoryId=
  	                 #{params[:categoryId]}&size=#{params[:size]}&from=#{params[:from]}
  	                 &city=#{params[:city]}"
  	ads = Utils.get(url, Api.ads_by_category)
  	ads
  end

end
