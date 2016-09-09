class AddUniqueIndexOnUsernameAndPlatform < ActiveRecord::Migration[5.0]
  def change
    add_index :users, [:platform_username, :platform], unique: true
  end
end
