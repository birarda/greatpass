class AddDeletionFlagsToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :receiver_deleted, :boolean, default: false, index: true
    add_column :conversations, :sender_deleted, :boolean, default: false, index: true
  end
end
