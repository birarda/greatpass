class AddIndexesToItems < ActiveRecord::Migration[5.0]
  def change
    add_index :items, :kind
    add_index :items, :rarity
  end
end
