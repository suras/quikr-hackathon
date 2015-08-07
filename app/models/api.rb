class Api
  
  def self.base_url
    Rails.application.secrets.api_base
  end
  
  def self.token
    "/app/auth/access_token"
  end

  def self.ads_by_category
    "/public/adsByCategory"
  end

end