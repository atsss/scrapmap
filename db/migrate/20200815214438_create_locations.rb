class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6

      t.timestamps
    end
    add_reference :places, :location, index: true, after: :channel_id
    add_reference :places, :original, index: true, after: :id
    add_column :places, :kind, :string, after: :name
  end
end
