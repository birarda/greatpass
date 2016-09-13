class User::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message_params = permitted_message_reply_params
    conversation = Conversation.find(message_params[:conversation_id])

    # now create our message in the conversation
    new_message = Message.new({
      conversation_id: conversation.id,
      sender_id: current_user.id,
      receiver_id: message_params[:receiver_id],
      body: message_params[:body]
    })

    if new_message.save
      render json: { status: 'success' }
    else
      render status: 400, json: { status: 'failure', errors: new_message.errors.full_messages }
    end
  end

  private
    def permitted_message_reply_params
      params.require(:message).permit(:conversation_id, :body, :receiver_id)
    end
end
