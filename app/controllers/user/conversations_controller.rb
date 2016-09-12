class User::ConversationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    # current_user.mailbox.conversations.find(params[:id]).move_to_trash current_user
    # redirect_to user_messages_path
  end

end
