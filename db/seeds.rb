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

files = Dir.glob("#{Rails.root}/db/seeds/csv/**/*")
files.each do |file|
  file = Rails.root.join("db", "seeds", "csv", file[48..-1])
  puts file
  chuva_observada = CSV.table(file).map{ |row| row.to_hash }
  array_chuva = []
  chuva_observada.each do |chuva|
    array_chuva << {date: chuva[:date], lon: chuva[:lon], lat: chuva[:lat], rain_late: chuva[:rain]}
  end
  Rain.import array_chuva, validate: false
end
