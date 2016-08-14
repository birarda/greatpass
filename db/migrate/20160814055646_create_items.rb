class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.uuid :item_id
      t.string :name

      t.timestamps
    end
  end
end
