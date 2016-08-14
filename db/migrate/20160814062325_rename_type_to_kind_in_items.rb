class RenameTypeToKindInItems < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :type, :kind
  end
end
