class User::MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inbox = current_user.inbox.page(params[:page])
  end

  def create
    message_params = permitted_message_params

    # if we have no conversation_id and we have a subject, we'll need to create a new conversation
    conversation = Conversation.new({
      subject: message_params[:subject],
      sender_id: current_user.id,
      receiver_id: message_params[:receiver_id]
    })

    # now create our message in the conversation
    message = conversation.messages.new({
      sender_id: current_user.id,
      body: message_params[:body]
    })

    if message.save
      render status: 200, json: { status: 'success' }
    else
      render status: 500, json: { status: 'failure' }
    end
  end

  private
    def permitted_message_params
      params.permit(:subject, :body, :receiver_id)
    end
end
