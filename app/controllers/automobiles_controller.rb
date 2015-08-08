class AutomobilesController < ApplicationController
  def ads
    params[:size] ||= 10
    if(params[:attrs].present?)
      Automobile.get_ads_from_attr(params[:attrs])
    else
      automobiles = Automobile.order("RANDOM()").limit(params[:size])
    end
    render json: automobiles
  end

  def fetch_ads
    params[:categordId] = 71
    params[:size] = 20 unless params[:size].present?
    params[:from] = 0 unless params[:from].present?
    params[:city] = "bangalore" unless params[:city].present?
    ads = Automobile.get_ads(params)
    render json: ads
  end

  def likes
  	auto = Automobile.find(params[:id])
  	auto.likes = (auto.likes += 1)
  	auto.save!
  	render json: {status: "success"}
  rescue => e
  	render json: {status: "error", message: e}, status: 404
  end
end
