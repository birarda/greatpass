class ItemsController < ApplicationController

  def index
    # setup the special options for certification/paint color
    @certification_options = UserItem.certifications.sort.map { |k,v| [k.capitalize, v] }
    @certification_options.insert(0, ['Any', -1], ['None', -2])

    @paint_options = UserItem.paint_colors.sort.map { |k, v| [k.titleize, v] }
    @paint_options.insert(0, ['Any', -1], ['None', -2])

    @items = Item.all

    @search_params = {}
  end

  def search
    # setup the special options for certification/paint color
    @certification_options = UserItem.certifications.sort.map { |k,v| [k.capitalize, v] }
    @certification_options.insert(0, ['Any', -1], ['None', -2])

    @paint_options = UserItem.paint_colors.sort.map { |k, v| [k.titleize, v] }
    @paint_options.insert(0, ['Any', -1], ['None', -2])

    @items = Item.all

    # check if we were passed any search parameters
    @search_params = permitted_search_params

    if !@search_params.has_key?(:search_type)
      @search_params[:search_type] = 'i'
    end

    if @search_params[:search_type] == 'w'
      query = UserItem.wishlist
    else
      query = UserItem.inventory
    end

    if @search_params.has_key?(:item_slug)
      @hero_item = Item.find_by_url_slug(@search_params[:item_slug].downcase)

      if !@hero_item
        @hero_item ||= Item.find(@search_params[:item_slug].to_i)
      end

      @search_params[:item_id] = [@hero_item.id]
    end

    if @search_params.has_key?(:item_id)
      query = query.where(item_id: @search_params[:item_id])
    end

    # if we have a platform_string (a clean path to a platform user)
    # then convert that to the platform array so it can be used below
    if @search_params.has_key?(:platform_string)
      @search_params[:platform] = [platform_from_url_string(@search_params[:platform_string])]
    end

    # if we have a current logged in user, default to searching on their platform
    # @search_params[:platform] = User.platforms[current_user.platform] if current_user && !@search_params.has_key?(:platform)

    if @search_params.has_key?(:platform)
      query = query.where(users: { platform: @search_params[:platform] })
    end

    if @search_params.has_key?(:platform_username)
      if @search_params.has_key?(:platform_string)
        @hero_user = User.where(
          'platform_username ILIKE ? AND platform = ?',
          @search_params[:platform_username],
          platform_from_url_string(@search_params[:platform_string])
        ).first

        if @hero_user
          query = query.references(:users).where(users: { id: @hero_user.id })
        else
          @result_items = UserItem.none.page(params[:page])
          return
        end
      else
        query = query.references(:users).where('platform_username ILIKE ?', @search_params[:platform_username])
      end
    end

    [:certification, :paint_color].each do |filter|
      if @search_params.has_key?(filter)
        # pull out the Any/None options
        query_any = @search_params[filter].include?('-1')
        query_none = @search_params[filter].include?('-2')

        if !query_any || !query_none
          if !@search_params[filter].empty?
            if query_any == query_none
              query = query.where("#{filter.to_s} IN (?)", @search_params[filter])
            else
              query = query.where("#{filter.to_s} IN (?) OR #{filter.to_s} is #{query_any ? 'NOT NULL' : 'NULL'}", @search_params[filter])
            end
          elsif query_any
            query = query.where("#{filter.to_s} is NOT NULL")
          elsif query_none
            query = query.where("#{filter.to_s} is NULL")
          end
        end
      end
    end

    if @search_params.has_key?(:kind)
      query = query.where(items: { kind: @search_params[:kind] })
    end

    if @search_params.has_key?(:rare_class)
      query = query.where(items: { rare_class: @search_params[:rare_class] })
    end

    @result_items = query.includes(:item, :user).order(created_at: :desc).page(params[:page])
    @entry_name = (@search_params[:search_type] == 'w') ? 'wanted items' : 'owned items'
  end

  def matchmaker
    # setup the special options for certification/paint color
    @certification_options = UserItem.certifications.sort.map { |k,v| [k.capitalize, v] }
    @certification_options.insert(0, ['Any', -1], ['None', -2])

    @paint_options = UserItem.paint_colors.sort.map { |k, v| [k.titleize, v] }
    @paint_options.insert(0, ['Any', -1], ['None', -2])

    if params.has_key?(:match_have)
      @have_params = permitted_matchmaker_have_params
      @want_params = permitted_matchmaker_want_params
    end

    if @have_params && @want_params
      if @have_params[:item_id].blank? || @want_params[:item_id].blank?
        @result_items = UserItem.none.page(params[:page])
      else
        # find user items that match the given request
        query = UserItem.inventory.where(item_id: @want_params[:item_id]).joins(:user)

        if !@want_params[:certification_id].blank?
          if @want_params[:certification_id] == '-1' # Any
            query = query.where('user_items.certification IS NOT NULL')
          elsif @want_params[:certification_id] == '-2' # None
            query = query.where(certification: nil)
          else
            query = query.where(certification: @want_params[:certification_id])
          end
        end

        if !@want_params[:paint_color_id].blank?
          if @want_params[:paint_color_id] == '-1' # Any
            query = query.where('user_items.paint_color IS NOT NULL')
          elsif @want_params[:paint_color_id] == '-2' # None
            query = query.where(paint_color: nil)
          else
            query = query.where(paint_color: @want_params[:paint_color_id])
          end
        end

        if !@have_params[:platform].blank?
          query = query.where('users.platform = ?', @have_params[:platform].to_i)
        end


        wishlist_query = UserItem.where('user_id = users.id')
                                 .where('item_id = ? AND list = ?', @have_params[:item_id], UserItem.lists[:wishlist])

        if !@have_params[:certification_id].blank?
          if @have_params[:certification_id] == '-1' # Any
            wishlist_query = wishlist_query.where('user_items.certification IS NOT NULL')
          elsif @have_params[:certification_id] == '-2' # None
            wishlist_query = wishlist_query.where('user_items.certification IS NULL')
          else
            wishlist_query = wishlist_query.where('certification = ?', @have_params[:certification_id])
          end
        end

        if !@have_params[:paint_color_id].blank?
          if @have_params[:paint_color_id] == '-1' # Any
            wishlist_query = wishlist_query.where('paint_color IS NOT NULL')
          elsif @have_params[:paint_color_id] == '-2' # None
            wishlist_query = wishlist_query.where('paint_color IS NULL')
          else
            wishlist_query = wishlist_query.where('paint_color = ?', @have_params[:paint_color_id])
          end
        end

        if current_user
          wishlist_query.where('user_items.user_id != ?', current_user.id)
        end

        @result_items = query.where(wishlist_query.exists).includes(:item, :user).order(created_at: :desc).page(params[:page])
      end

      @entry_name = 'match'
    else
      @have_params = {}
      @want_params = {}

      if current_user
        # default the platform to the current user's platform
        @have_params[:platform] = User.platforms[current_user.platform]
      end
    end
  end

  private
    def permitted_search_params
      permitted_params = params.permit(:platform_string, :platform_username, :search_type, :item_slug, item_id: [], certification: [], paint_color: [], platform: [], kind: [], rare_class: [])

      permitted_params.keys.each do |filter|
        permitted_params[filter].reject! { |i| i.empty? } if permitted_params[filter].kind_of?(Array)
        permitted_params.delete(filter) if permitted_params[filter].empty?
      end

      permitted_params
    end

    def permitted_matchmaker_have_params
      params.require(:match_have).permit(:item_id, :certification_id, :paint_color_id, :platform)
    end

    def permitted_matchmaker_want_params
      params.require(:match_want).permit(:item_id, :certification_id, :paint_color_id, :platform)
    end
end
