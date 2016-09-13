class ChangeIndexForConversationsWithDelete < ActiveRecord::Migration[5.0]
  def change
    remove_index :conversations, :receiver_id
    add_index :conversations, [:receiver_id, :receiver_deleted]
    remove_index :conversations, :sender_id
    add_index :conversations, [:sender_id, :sender_deleted]
  end
end
