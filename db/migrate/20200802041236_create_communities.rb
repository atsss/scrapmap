class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.string :kind
      t.string :name

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :communities, :deleted_at
    add_reference :channels, :community, index: true, after: :id
  end
end
