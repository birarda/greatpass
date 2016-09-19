class AddEmailNotificationsEnabledToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_notifications_enabled, :boolean, default: false
  end
end
