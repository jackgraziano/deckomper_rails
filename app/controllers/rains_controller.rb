class RainsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @dates = Rain.distinct.pluck(:date).sort.reverse
  end

  def grande
    grande = [
              { lat: -21.40, lon: -44.20 },
              { lat: -21.40, lon: -44.60 },
              { lat: -21.80, lon: -44.20 },
              { lat: -21.80, lon: -44.60 },
              { lat: -22.20, lon: -44.60 },
              { lat: -21.00, lon: -43.80 },
              { lat: -21.00, lon: -44.20 },
              { lat: -21.00, lon: -44.60 },
              { lat: -21.00, lon: -45.00 },
              { lat: -21.40, lon: -43.80 },
              { lat: -21.80, lon: -45.00 },
              { lat: -21.80, lon: -45.40 },
              { lat: -22.20, lon: -45.00 },
              { lat: -22.20, lon: -45.40 },
              { lat: -21.80, lon: -45.80 },
              { lat: -22.20, lon: -45.80 },
              { lat: -22.20, lon: -46.20 },
              { lat: -22.60, lon: -45.40 },
              { lat: -22.60, lon: -45.80 },
              { lat: -20.60, lon: -45.40 },
              { lat: -20.60, lon: -45.80 },
              { lat: -20.60, lon: -46.20 },
              { lat: -21.00, lon: -45.40 },
              { lat: -21.00, lon: -45.80 },
              { lat: -21.00, lon: -46.20 },
              { lat: -21.40, lon: -45.00 },
              { lat: -21.40, lon: -45.40 },
              { lat: -21.40, lon: -45.80 },
              { lat: -21.40, lon: -46.20 },
              { lat: -21.40, lon: -46.60 },
              { lat: -21.80, lon: -46.20 },
              { lat: -20.60, lon: -47.40 },
              { lat: -20.60, lon: -47.80 },
              { lat: -21.00, lon: -47.00 },
              { lat: -21.00, lon: -47.40 },
              { lat: -19.80, lon: -47.40 },
              { lat: -19.80, lon: -47.80 },
              { lat: -19.80, lon: -48.20 },
              { lat: -20.20, lon: -47.00 },
              { lat: -20.20, lon: -47.40 },
              { lat: -20.20, lon: -47.80 },
              { lat: -20.20, lon: -48.20 },
              { lat: -20.60, lon: -46.60 },
              { lat: -20.60, lon: -47.00 },
              { lat: -21.00, lon: -46.60 },
              { lat: -21.80, lon: -46.60 },
              { lat: -21.40, lon: -47.80 },
              { lat: -21.40, lon: -48.20 },
              { lat: -21.80, lon: -47.40 },
              { lat: -21.80, lon: -47.80 },
              { lat: -22.20, lon: -46.60 },
              { lat: -22.20, lon: -47.00 },
              { lat: -22.20, lon: -47.40 },
              { lat: -22.60, lon: -46.20 },
              { lat: -22.60, lon: -46.60 },
              { lat: -19.80, lon: -48.60 },
              { lat: -20.20, lon: -48.60 },
              { lat: -20.20, lon: -49.00 },
              { lat: -20.60, lon: -48.20 },
              { lat: -20.60, lon: -48.60 },
              { lat: -21.00, lon: -47.80 },
              { lat: -21.00, lon: -48.20 },
              { lat: -21.40, lon: -47.00 },
              { lat: -21.40, lon: -47.40 },
              { lat: -21.80, lon: -47.00 },
              { lat: -19.80, lon: -49.00 },
              { lat: -19.80, lon: -49.40 },
              { lat: -19.80, lon: -49.80 },
              { lat: -19.80, lon: -50.20 },
              { lat: -20.20, lon: -49.40 },
              { lat: -20.20, lon: -49.80 },
              { lat: -20.20, lon: -50.20 },
              { lat: -20.60, lon: -49.00 },
              { lat: -20.60, lon: -49.40 },
              { lat: -21.00, lon: -48.60 },
              { lat: -21.00, lon: -49.00 },
            ]

    lat = []
    lon = []
    grande.each do |point|
      lat << point[:lat]
      lon << point[:lon]
    end
    @rain = Rain.where(lon: lon, lat: lat)
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=grande.csv"
        render :template => "rains/grande.csv.erb"
      end
    end
  end

  def show
    date = params[:id].to_s
    @rains = Rain.where(date: Date.parse(date))
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=chuva_observada_#{date}.csv"
        render :template => "rains/template.csv.erb"
      end
      format.json do
        render json: { chuva_observada: @rains}
      end
    end
  end

  def create
    @chuva_observada = params[:chuva_observada]
    array_chuva = []
    @chuva_observada.each do |chuva|
      chuva[:rain_late] = chuva[:rain]
      chuva.delete("rain")
      array_chuva << chuva.to_hash
    end
    puts '*'*100
    p array_chuva
    puts '*'*100
    Rain.import array_chuva, validate: false

    # @chuva_observada.each do |chuva|
    #   # chuva[:date], chuva[:lon]

    #   # checa se registro existe
    #   if Rain.find_by_date_and_lon_and_lat(Date.parse(chuva[:date]), chuva[:lon].to_f, chuva[:lat].to_f).nil?
    #     # nao existe - cria registro
    #     a = Rain.new
    #     a.date = Date.parse(chuva[:date])
    #     a.lat = chuva[:lat].to_f
    #     a.lon = chuva[:lon].to_f
    #     a.rain_late = chuva[:rain].to_f
    #     a.save
    #   else
    #     # update
    #     a = Rain.find_by_date_and_lon_and_lat(Date.parse(chuva[:date]), chuva[:lon].to_f, chuva[:lat].to_f)
    #     a.date = Date.parse(chuva[:date])
    #     a.lat = chuva[:lat].to_f
    #     a.lon = chuva[:lon].to_f
    #     a.rain_late = chuva[:rain].to_f
    #     a.save
    #   end
    # end
  end

end
