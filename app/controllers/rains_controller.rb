class RainsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @dates = Rain.distinct.pluck(:date)
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
