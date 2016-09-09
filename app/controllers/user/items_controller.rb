class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_item = current_user.items.new

    @items = current_user.items.includes(:item).order('items.name ASC')
  end

  def create
    @new_item = current_user.items.new(new_item_params)

    if @new_item.save
      flash[:success] = "Added <strong>#{@new_item.to_s}</strong> to your inventory"
      redirect_to action: 'index'
    else
      @items = current_user.items.includes(:item).order('items.name ASC')
      render :index
    end
  end

  def destroy
    @matching_item = current_user.items.find(params[:id])

    @item_string = @matching_item.try(:to_s)
    if @matching_item && @matching_item.destroy
      flash[:notice] = "Removed <strong>#{@item_string}</strong> from your inventory"

      redirect_to action: 'index'
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private
    def new_item_params
      with_kinds = params.require(:user_item).permit(:item_id, :certified, :painted, :certification, :paint_color)
      with_kinds.delete(:certification) if with_kinds[:certified].to_i == 0
      with_kinds.delete(:paint_color) if with_kinds[:painted].to_i == 0

      return with_kinds
    end

end
