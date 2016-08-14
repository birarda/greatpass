class AddRarityToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :rarity, :integer, default: 0
  end
end
