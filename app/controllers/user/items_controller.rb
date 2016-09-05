class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def inventory
    @new_item = current_user.items.new
  end

end
