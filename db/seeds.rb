# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
# file = Rails.root.join("db", "seeds", "seeds.csv")
# csv = CSV.read(file)

# csv.each do |line|
#   a = Rain.new
#   a.date = Date.parse(line[0])
#   a.lon = line[1].to_f
#   a.lat = line[2].to_f
#   a.rain_late = line[3].to_f
#   a.save
# end

# file = Rails.root.join("db", "seeds", "bacia_grande.csv")
# csv = CSV.read(file)

# csv.each do |line|
#   a = Basin.new
#   a.bacia = line[0]
#   a.sub_bacia = line[1]
#   a.lon = line[2].to_f
#   a.lat = line[3].to_f
#   a.save
# end

files = [
  "MERGE_GPM_late_2016120112_ETA.csv",
  "MERGE_GPM_late_2016120212_ETA.csv",
  "MERGE_GPM_late_2016120312_ETA.csv",
  "MERGE_GPM_late_2016120412_ETA.csv",
  "MERGE_GPM_late_2016120512_ETA.csv",
  "MERGE_GPM_late_2016120612_ETA.csv",
  "MERGE_GPM_late_2016120712_ETA.csv",
  "MERGE_GPM_late_2016120812_ETA.csv",
  "MERGE_GPM_late_2016120912_ETA.csv",
  "MERGE_GPM_late_2016121012_ETA.csv",
  "MERGE_GPM_late_2016121112_ETA.csv",
  "MERGE_GPM_late_2016121212_ETA.csv",
  "MERGE_GPM_late_2016121312_ETA.csv",
  "MERGE_GPM_late_2016121412_ETA.csv",
  "MERGE_GPM_late_2016121512_ETA.csv",
  "MERGE_GPM_late_2016121612_ETA.csv",
  "MERGE_GPM_late_2016121712_ETA.csv",
  "MERGE_GPM_late_2016121812_ETA.csv",
  "MERGE_GPM_late_2016121912_ETA.csv",
  "MERGE_GPM_late_2016122012_ETA.csv",
  "MERGE_GPM_late_2016122112_ETA.csv",
  "MERGE_GPM_late_2016122212_ETA.csv",
  "MERGE_GPM_late_2016122312_ETA.csv",
  "MERGE_GPM_late_2016122412_ETA.csv",
  "MERGE_GPM_late_2016122512_ETA.csv",
  "MERGE_GPM_late_2016122612_ETA.csv",
  "MERGE_GPM_late_2016122712_ETA.csv",
  "MERGE_GPM_late_2016122812_ETA.csv",
  "MERGE_GPM_late_2016122912_ETA.csv",
  "MERGE_GPM_late_2016123012_ETA.csv",
  "MERGE_GPM_late_2016123112_ETA.csv",
]
files.each do |file|
  file = Rails.root.join("db", "seeds", "csv", file)
  puts file
  chuva_observada = CSV.table(file).map{ |row| row.to_hash }
  array_chuva = []
  chuva_observada.each do |chuva|
    array_chuva << {date: chuva[:date], lon: chuva[:lon], lat: chuva[:lat], rain_late: chuva[:rain]}
  end
  Rain.import array_chuva, validate: false
end
