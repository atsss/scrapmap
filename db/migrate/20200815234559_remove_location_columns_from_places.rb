class RemoveLocationColumnsFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :lat, :float
    remove_column :places, :lng, :float
  end
end
