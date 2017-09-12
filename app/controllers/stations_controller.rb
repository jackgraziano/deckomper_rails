class StationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @stations = JSON.parse(params[:stations])
    puts '*'*100
    puts params
    puts '*'*100
    array = []
    @stations.each do |station|
      array << station.to_hash
    end
    Station.import array, validate: false
  end

end
