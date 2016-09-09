class AddRedditUsernameToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reddit_username, :string
  end
end
