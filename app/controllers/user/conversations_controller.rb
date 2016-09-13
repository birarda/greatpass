class User::ConversationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    conversation = Conversation.find(params[:id])

    if conversation.sender_id == current_user.id
      update_hash = { sender_deleted: true }
    elsif conversation.receiver_id == current_user.id
      update_hash = { receiver_deleted: true }
    end

    if update_hash && conversation.update_columns(update_hash)
      redirect_to user_messages_path
    else

    end
  end

end
