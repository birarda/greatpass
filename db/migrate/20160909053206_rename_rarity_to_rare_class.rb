class RenameRarityToRareClass < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :rarity, :rare_class
  end
end
