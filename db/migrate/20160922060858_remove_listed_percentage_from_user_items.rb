class RemoveListedPercentageFromUserItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_items, :listed_percentage
  end
end
