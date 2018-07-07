class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :codigo
      t.float :velocidade_atual
      t.string :log
      t.string :lat

      t.timestamps null: false
    end
  end
end
