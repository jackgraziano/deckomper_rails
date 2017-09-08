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
    puts params.inspect
    @chuva_observada = params[:chuva_observada]
    @chuva_observada.each do |chuva|
      # chuva[:date], chuva[:lon]
      a = Rain.new
      a.date = Date.parse(chuva[:date])
      a.lat = chuva[:lat].to_f
      a.lon = chuva[:lon].to_f
      a.rain_late = chuva[:rain].to_f
      a.save
    end
  end

end
