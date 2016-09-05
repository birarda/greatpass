class AddPaintColorToUserItems < ActiveRecord::Migration[5.0]
  def change
    add_column :user_items, :paint_color, :integer
  end
end
