class AddIndexesForMessages < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    add_index :messages, :conversation_id
    add_index :conversations, :sender_id
    add_index :conversations, :receiver_id
  end
end
