class BasinsController < ApplicationController
  def index
    @rain = Rain.where(date: Date.parse('2017-09-01'))
    @grande = @rain.joins("INNER JOIN basins ON basins.lat = rains.lat AND basins.lon = rains.lon AND basins.bacia = 'Grande'")
  end
end
