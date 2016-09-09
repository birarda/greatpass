class AddListToUserItems < ActiveRecord::Migration[5.0]
  def self.up
    add_column :user_items, :list, :integer

    UserItem.all.update_all(list: 0)
  end

  def self.down
    remove_column :user_items, :list
  end
end
