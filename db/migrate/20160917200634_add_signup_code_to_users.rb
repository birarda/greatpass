class AddSignupCodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :signup_code, :string
  end
end
