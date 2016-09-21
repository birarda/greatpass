class MessageMailer < ApplicationMailer
  default from: 'Great Pass <noreply@greatpass.io>'

  def message_notification_email(message_id)
    @message = Message.find(message_id)
    mail(to: @message.receiver.email, subject: "Message from #{@message.sender.platform_username} - Great Pass")
  end
end
