class AddPlatformInformationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :platform, :integer
    add_column :users, :platform_username, :string
  end
end
