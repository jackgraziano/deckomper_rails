class CreateBasins < ActiveRecord::Migration[5.0]
  def change
    create_table :basins do |t|
      t.string :bacia
      t.string :sub_bacia
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
