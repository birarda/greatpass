class AddPlatformUrlToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :platform_url, :string
  end
end
