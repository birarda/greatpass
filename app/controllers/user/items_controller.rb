class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_item = current_user.items.new

    @items = current_user.items.joins(:item).order('items.name ASC')
  end

  def create
    @new_item = current_user.items.new(new_item_params)

    if @new_item.save
      redirect_to action: 'index'
    else
      render :index
    end
  end

  def destroy
    @matching_item = current_user.items.find(params[:id])

    if @matching_item
      @matching_item.destroy
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
