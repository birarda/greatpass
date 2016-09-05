class AddCertificationToUserItem < ActiveRecord::Migration[5.0]
  def change
    add_column :user_items, :certification, :integer
  end
end
