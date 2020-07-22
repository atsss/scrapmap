class AddUrlColumnsToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :google_map_url, :string, after: :lat
    add_column :places, :uber_eats_url, :string, after: :google_map_url
  end
end
