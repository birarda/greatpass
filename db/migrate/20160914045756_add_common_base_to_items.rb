class AddCommonBaseToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :common_base, :boolean, default: false
  end
end
