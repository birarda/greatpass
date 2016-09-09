class UsersController < ApplicationController
  before_action :authenticate_same_user!, only: [:update]

  def wishlist
    @platform_user = User.where(
      'platform_username ILIKE ? AND platform = ?',
      params[:platform_username],
      platform_from_url_string(params[:platform_string])
    ).first

    if @platform_user
      @result_items = @platform_user.wishlist
    else
      @result_items = UserItem.none
    end

    @result_items = @result_items.includes(:item).order('items.name ASC').page(params[:page])
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
      params.require(:user).permit(:platform, :platform_username, :platform_url)
    end

end
