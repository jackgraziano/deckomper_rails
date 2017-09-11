class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :posto
      t.float :lon
      t.float :lat
      t.string :bacia
      t.float :rain
      t.date :date

      t.timestamps
    end
  end
end
