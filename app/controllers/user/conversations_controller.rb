class User::ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @inbox = current_user.inbox.page(params[:page])
  end

  def show
    @conversation = Conversation.find(params[:id])
    raise ActiveRecord::RecordNotFound if (@conversation.sender_id != current_user.id && @conversation.receiver_id != current_user.id)

    @messages = @conversation.messages.includes(:sender).order('created_at ASC')

    # mark everything that was sent to us as read
    @conversation.messages.where(receiver_id: current_user.id).update_all(read: true)

    @reply_message = Message.new(conversation_id: @conversation.id, sender_id: current_user.id, receiver_id: @conversation.other_user(current_user).id)
  end

  def create
    message_params = permitted_message_params

    # if we have no conversation_id and we have a subject, we'll need to create a new conversation
    conversation = Conversation.new({
      subject: message_params[:subject],
      sender_id: current_user.id,
      receiver_id: message_params[:receiver_id]
    })

    message = conversation.messages.new({
      sender_id: current_user.id,
      receiver_id: message_params[:receiver_id],
      body: message_params[:body]
    })

    if message.save
      render status: 200, json: { status: 'success' }
    else
      render status: 400, json: { status: 'failure', errors: message.errors.full_messages }
    end
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

      redirect_to user_inbox_path
    else
      flash[:error] = "There was a problem deleting that conversation. Please try again."
      redirect_to user_inbox_path
    end
  end

  private
    def permitted_message_params
      params.permit(:subject, :body, :receiver_id)
    end

end
