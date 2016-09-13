class AddReceiverIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :receiver_id, :integer, index: true
  end
end
