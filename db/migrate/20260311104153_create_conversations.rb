class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :user,null: true, foreign_key: { to_table: :users}
      t.references :staff,null: true, foreign_key: { to_table: :users }
      t.integer :status, default: 0, null: false
      t.integer :department, default: 0, null: false

      t.timestamps
    end
  end
end
