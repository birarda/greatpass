class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_item = current_user.items.new

    @items = current_user.inventory.includes(:item).order('items.name ASC').page(params[:page])
  end

  def wishlist
    @new_item = current_user.items.new

    @items = current_user.wishlist.includes(:item).order('items.name ASC').page(params[:page])
  end

  def wishlist_clear
    @items = current_user.wishlist.destroy_all
    flash[:notice] = "Removed all items from your wishlist"
    redirect_to user_wishlist_index_path
  end

  def inventory_clear
    @items = current_user.inventory.destroy_all
    flash[:notice] = "Removed all items from your inventory"
    redirect_to user_items_path
  end

  def create
    @new_item = current_user.items.new(new_item_params)

    redirect_action = @new_item.inventory? ? 'index' : 'wishlist'

    if @new_item.save
      flash[:success] = "Added <strong>#{@new_item.to_s}</strong> to your #{@new_item.list}"
      redirect_to action: redirect_action
    else

      @items = @new_item.inventory? ? current_user.inventory : current_user.wishlist
      @items = @items.includes(:item).order('items.name ASC').page(params[:page])
      render redirect_action
    end
  end

  def destroy
    @matching_item = current_user.items.find(params[:id])

    @item_string = @matching_item.try(:to_s)
    @item_list = @matching_item.try(:list)

    if @matching_item && @matching_item.destroy
      flash[:notice] = "Removed <strong>#{@item_string}</strong> from your #{@item_list}"

      redirect_to action: (@item_list == 'inventory' ? 'index' : 'wishlist')
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private
    def new_item_params
      with_kinds = params.require(:user_item).permit(:item_id, :list, :certified, :painted, :certification, :paint_color)
      with_kinds.delete(:certification) if with_kinds[:certified].to_i == 0
      with_kinds.delete(:paint_color) if with_kinds[:painted].to_i == 0

      return with_kinds
    end

end
