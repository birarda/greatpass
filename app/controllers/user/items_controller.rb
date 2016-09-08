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
      with_kind = params.require(:user_item).permit(:item_id, :kind, :certification, :paint_color)

      if with_kind[:kind].to_i == 0
        with_kind.delete(:certification).delete(:paint_color)
      elsif with_kind[:kind].to_i === 1
        with_kind.delete(:paint_color)
      elsif with_kind[:kind].to_i == 2
        with_kind.delete(:certification)
      end

      return with_kind
    end

end
