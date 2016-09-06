class ItemsController < ApplicationController

  def search
    # check if we were passed any search parameters
    search_params = permitted_search_params

    # if all query params are empty, simply return all sorted by recency
    if search_params.empty?
      @result_items = UserItem.all.order(created_at: :desc)
    end
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
