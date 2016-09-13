class User::ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def destroy
    conversation = Conversation.find(params[:id])

    if conversation.sender_id == current_user.id
      update_hash = { sender_deleted: true }
    elsif conversation.receiver_id == current_user.id
      update_hash = { receiver_deleted: true }
    end

    if update_hash && conversation.update_columns(update_hash)

      # we need to mark all messages up to this point in the conversation as read
      # so that they do not get counted in the navbar
      conversation.messages.where(receiver_id: current_user.id).update_all(read: true)

      redirect_to user_messages_path
    else

    end
  end

end
