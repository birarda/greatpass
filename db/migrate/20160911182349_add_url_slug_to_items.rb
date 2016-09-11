class AddUrlSlugToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :url_slug, :string
    add_index :items, :url_slug
  end
end
