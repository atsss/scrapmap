class AddChannelIdToPaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :channel, index: true, after: :id
  end
end
