class UsersController < ApplicationController
  before_action :authenticate_same_user!, only: [:update]

  def show

  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(update_params)
      flash[:success] = "Platform / Gamertag updated"
    end

    redirect_to edit_user_registration_path
  end

  private
    def authenticate_same_user!
      unless current_user && current_user.id == params[:id].to_i
        render status: 401
      end
    end

    def update_params
      params.require(:user).permit(:platform, :platform_username)
    end

end
