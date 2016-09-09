class AddIndexesToUserItems < ActiveRecord::Migration[5.0]
  def change
    add_index :user_items, :user_id
    add_index :user_items, :item_id
    add_index :user_items, :list
    add_index :user_items, :certification
    add_index :user_items, :paint_color
  end
end
