class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :place, null: false
      t.text :content

      t.timestamps
    end
  end
end
