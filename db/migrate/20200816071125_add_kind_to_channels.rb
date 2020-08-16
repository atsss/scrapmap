class AddKindToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :kind, :string, after: :name
  end
end
