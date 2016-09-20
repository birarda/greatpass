class AddListedPercentageToUserItems < ActiveRecord::Migration[5.0]
  def change
    add_column :user_items, :listed_percentage, :float
  end
end
