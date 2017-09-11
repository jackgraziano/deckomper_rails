class StationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @stations = JSON.parse(params[:stations])
    puts '*'*100
    puts params
    puts '*'*100
    array = []
    @stations.each do |station|
      station[:rain] = station[:chuva].to_f
      station.delete("chuva")
      array << station.to_hash
    end
    Station.import array, validate: false
  end

end
