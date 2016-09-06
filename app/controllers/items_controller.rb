class ItemsController < ApplicationController

  def search
    # check if we were passed any search parameters
    search_params = permitted_search_params

    query = UserItem.all

    # if all query params are empty, simply return all sorted by recency
    if !search_params.empty?

      if search_params.has_key?(:item_id)
        query = query.where(item_id: search_params[:item_id])
      end

      if search_params.has_key?(:platform)
        query = query.where(users: { platform: search_params[:platform] })
      end

      if search_params.has_key?(:certification)
        query = query.where(certification: search_params[:certification])
      end

      if search_params.has_key?(:paint_color)
        query = query.where(paint_Color: search_params[:paint_color])
      end

    end

    @result_items = query.joins(:item, :user).order(created_at: :desc).paginate(page: params[:page])
  end

  private
    def permitted_search_params
      permitted_params = params.permit(item_id: [], certification: [], paint_color: [], platform: [])

      permitted_params.keys.each do |filter|
        permitted_params[filter].reject! { |i| i.empty? }
        permitted_params.delete(filter) if permitted_params[filter].empty?
      end

      permitted_params
    end
end
