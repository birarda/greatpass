class ItemsController < ApplicationController

  def search
    # check if we were passed any search parameters
    @search_params = permitted_search_params

    query = UserItem.all

    # if all query params are empty, simply return all sorted by recency
    if !@search_params.empty?

      if @search_params.has_key?(:item_id)
        query = query.where(item_id: @search_params[:item_id])
      end

      # if we have a platform_string (a clean path to a platform user)
      # then convert that to the platform array so it can be used below
      if @search_params.has_key?(:platform_string)
        puts platform_from_url_string(@search_params[:platform_string])
        @search_params[:platform] = [platform_from_url_string(@search_params[:platform_string])]
      end

      if @search_params.has_key?(:platform)
        query = query.where(users: { platform: @search_params[:platform] })
      end

      if @search_params.has_key?(:platform_username)
        @platform_user = User.where('platform_username ILIKE ?', @search_params[:platform_username]).first
        query = query.references(:users).where(users: { id: @platform_user.id })
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

    end

    @result_items = query.includes(:item, :user).order(created_at: :desc).page(params[:page])
  end

  private
    def permitted_search_params
      permitted_params = params.permit(:platform_string, :platform_username, item_id: [], certification: [], paint_color: [], platform: [], kind: [])

      permitted_params.keys.each do |filter|
        permitted_params[filter].reject! { |i| i.empty? } if permitted_params[filter].kind_of?(Array)
        permitted_params.delete(filter) if permitted_params[filter].empty?
      end

      permitted_params
    end

    def platform_from_url_string(platform_string)
      downcase_platform = platform_string.downcase

      if downcase_platform == 'steam'
        User.platforms[:Steam]
      elsif downcase_platform == 'psn'
        User.platforms[:PSN]
      elsif downcase_platform == 'xbox'
        User.platforms[:Xbox]
      end
    end
end
