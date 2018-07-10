class AddDataToCars < ActiveRecord::Migration
  def change
    add_column :cars, :data, :datetime
  end
end
