class AddLogicalDeleteColumnsToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :deleted_at, :datetime, after: :updated_at
    add_index :notes, :deleted_at
    add_column :places, :deleted_at, :datetime, after: :updated_at
    add_index :places, :deleted_at
    add_column :channels, :deleted_at, :datetime, after: :updated_at
    add_index :channels, :deleted_at
  end
end
