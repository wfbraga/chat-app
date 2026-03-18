class AddClosedAtToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :closed_at, :datetime
    add_index :conversations, :closed_at
  end
end
