class MessageMailer < ApplicationMailer
  def message_notification_email(message)
    @message = message
    mail(to: @message.receiver.email, subject: "Message from #{message.sender.platform_username} - Great Pass")
  end
end
