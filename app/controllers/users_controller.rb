class UsersController < ApplicationController
  before_action :authenticate_same_user!, only: [:update]

  def inventory
    @hero_user = User.where(
      'reddit_username ILIKE ?',
      params[:reddit_username]
    ).first

    @for_reddit = true

    if @hero_user
      @result_items = @hero_user.inventory
    else
      raise ActiveRecord::RecordNotFound
    end

    @result_items = @result_items.includes(:item).order('items.name ASC').page(params[:page])
    @entry_name = 'owned items'
  end

  def wishlist
    @for_reddit = false

    if params.has_key?(:platform_username)
      @hero_user = User.where(
        'platform_username ILIKE ? AND platform = ?',
        params[:platform_username],
        platform_from_url_string(params[:platform_string])
      ).first
    elsif params.has_key?(:reddit_username)
      @hero_user = User.where(
        'reddit_username ILIKE ?',
        params[:reddit_username]
      ).first

      @for_reddit = true
    end

    if @hero_user
      @result_items = @hero_user.wishlist
    else
      raise ActiveRecord::RecordNotFound
    end

    @result_items = @result_items.includes(:item).order('items.name ASC').page(params[:page])
    @entry_name = 'wanted items'
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(update_params)
      flash[:success] = "Platform / Gamertag updated"
      redirect_to edit_user_registration_path
    else
      @resource = @user
      render 'devise/registrations/edit'
    end
  end

  private
    def authenticate_same_user!
      unless current_user && current_user.id == params[:id].to_i
        render status: 401
      end
    end

    def update_params
      params.require(:user).permit(:platform, :platform_username, :platform_url, :reddit_username)
    end

end
