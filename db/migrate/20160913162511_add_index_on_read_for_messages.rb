class AddIndexOnReadForMessages < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :read
  end
end
