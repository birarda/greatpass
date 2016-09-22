class CreateItemVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :item_variants do |t|
      t.integer :item_id
      t.integer :certification
      t.integer :paint_color
      t.float :inventory_percentage
      t.float :wishlist_percentage

      t.timestamps
    end

    add_index :item_variants, [:item_id, :certification, :paint_color], unique: true, name: 'item_variant_id_cert_paint_index'
  end
end
