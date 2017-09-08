class CreateRains < ActiveRecord::Migration[5.0]
  def change
    create_table :rains do |t|
      t.date :date
      t.float :lon
      t.float :lat
      t.float :rain_early
      t.float :rain_late

      t.timestamps
    end
  end
end
