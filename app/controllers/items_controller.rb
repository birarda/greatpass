class ItemsController < ApplicationController

  def search
    # check if we were passed any search parameters
    @search_params = permitted_search_params

    query = UserItem.inventory

    # if all query params are empty, simply return all sorted by recency
    if !@search_params.empty?

      if @search_params.has_key?(:item_id)
        query = query.where(item_id: @search_params[:item_id])
      end

      # if we have a platform_string (a clean path to a platform user)
      # then convert that to the platform array so it can be used below
      if @search_params.has_key?(:platform_string)
        @search_params[:platform] = [platform_from_url_string(@search_params[:platform_string])]
      end

      if @search_params.has_key?(:platform)
        query = query.where(users: { platform: @search_params[:platform] })
      end

      if @search_params.has_key?(:platform_username)
        @platform_user = User.where('platform_username ILIKE ?', @search_params[:platform_username]).first
        if @platform_user
          query = query.references(:users).where(users: { id: @platform_user.id })
        else
          @result_items = UserItem.none.page(params[:page])
          return
        end
      end

      if @search_params.has_key?(:certification)
        query = query.where(certification: @search_params[:certification])
      end

      if @search_params.has_key?(:paint_color)
        query = query.where(paint_color: @search_params[:paint_color])
      end

      if @search_params.has_key?(:kind)
        query = query.where(items: { kind: @search_params[:kind] })
      end

      if @search_params.has_key?(:rarity)
        query = query.where(items: { rarity: @search_params[:rarity] })
      end

    end

    @result_items = query.includes(:item, :user).order(created_at: :desc).page(params[:page])
  end

  private
    def permitted_search_params
      permitted_params = params.permit(:platform_string, :platform_username, item_id: [], certification: [], paint_color: [], platform: [], kind: [], rarity: [])

      permitted_params.keys.each do |filter|
        permitted_params[filter].reject! { |i| i.empty? } if permitted_params[filter].kind_of?(Array)
        permitted_params.delete(filter) if permitted_params[filter].empty?
      end

      permitted_params
    end
end
