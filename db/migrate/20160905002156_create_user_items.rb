class CreateUserItems < ActiveRecord::Migration[5.0]
  def change
    create_table :user_items do |t|
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
