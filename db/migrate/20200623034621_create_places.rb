class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
