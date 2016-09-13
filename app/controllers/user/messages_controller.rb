class User::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message_params = permitted_message_reply_params
    conversation = Conversation.find(message_params[:conversation_id])

    # now create our message in the conversation
    new_message_params = {
      sender_id: current_user.id,
      receiver_id: message_params[:receiver_id],
      body: message_params[:body]
    }

    if conversation.messages.create(new_message_params)
      redirect_to user_conversation_path(conversation)
    else
      # failure in responding to message
    end
  end

  private
    def permitted_message_reply_params
      params.require(:message).permit(:conversation_id, :body, :receiver_id)
    end
end
