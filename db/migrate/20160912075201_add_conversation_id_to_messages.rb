class AddConversationIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :conversation_id, :integer, index: true
  end
end
