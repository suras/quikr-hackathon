require 'base64'
require 'cgi'
require 'openssl'

class Utils
  @@token_hash =  nil;
  def self.hmac_sha1(data, secret=HOST_KEY)
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret.encode("ASCII"), data.encode("ASCII"))
    return hmac
  end

  def self.app_id
    Rails.application.secrets.app_id
  end

  def self.app_name
    Rails.application.secrets.app_name
  end

  def self.app_secret
    Rails.application.secrets.app_secret
  end

  def self.app_email
    Rails.application.secrets.app_email
  end

  def self.token
    if(@@token_hash == nil )
      @@token_hash = get_token
    end
    @@token_hash
  end

  def self.get(url, api_name)
    signature = hmac_sha1(app_id.to_s + api_name + date, token[:token])
    response = Unirest.get(url, 
                          headers:{ "X-Quikr-App-Id" => app_id,
                          "X-Quikr-Token-Id" => token[:token_id],
                          "X-Quikr-Signature" => signature}).body
  end

  def self.date
    Time.now.strftime("%Y-%m-%d")
  end

  def self.get_token
    data = app_email+app_id.to_s+date
    signature = hmac_sha1(data, app_secret)
    response = Unirest.post(Api.base_url+Api.token, 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{appId: app_id, signature: signature})
    response = response.body
    if(response["error"] == "false")
      {token: response["token"], token_id: response["tokenId"]}
    else
      nil
    end
  end

end