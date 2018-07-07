class CreateTraffics < ActiveRecord::Migration
  def change
    create_table :traffics do |t|
      t.string :lat
      t.string :log
      t.references :Car, index: true, foreign_key: true
      t.datetime :tempo

      t.timestamps null: false
    end
  end
end
