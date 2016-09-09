class AddUniqueIndexOnNameAndKind < ActiveRecord::Migration[5.0]
  def change
    add_index :items, [:name, :kind], unique: true
  end
end
