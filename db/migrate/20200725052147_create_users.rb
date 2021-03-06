class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
    add_reference :accounts, :user, index: true, after: :id
    add_reference :notes, :user, index: true, after: :id
  end
end
