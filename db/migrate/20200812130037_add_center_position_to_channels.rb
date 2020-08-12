class AddCenterPositionToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :center_lat, :float, after: :name
    add_column :channels, :center_lng, :float, after: :center_lat
  end
end
