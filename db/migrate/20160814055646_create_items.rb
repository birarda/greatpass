class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.column :type, :integer, default: 0

      t.timestamps
    end
  end
end
