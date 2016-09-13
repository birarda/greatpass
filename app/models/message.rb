# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :text
#  sender_id       :integer
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer
#  receiver_id     :integer
#

class Message < ApplicationRecord
  belongs_to :conversation, touch: true
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :conversation, presence: true
  validates :body, length: { maximum: 1000, minimum: 1 }

  before_create :remove_conversation_delete_flags

  validate :matches_conversation

  private
    def remove_conversation_delete_flags
      self.conversation.update(receiver_deleted: false, sender_deleted: false)
    end

    def matches_conversation
      return if self.conversation.nil?

      # either the sender of message is sender of convo, with receiver as receiver of convo
      # or the sender of message is receiver of convo, with sender as receiver of convo

      if !(self.sender_id == self.conversation.sender_id && self.receiver_id == self.conversation.receiver_id) &&
         !(self.receiver_id == self.conversation.sender_id && self.sender_id == self.conversation.receiver_id)
          errors.add(:message, 'must be sent in matching thread')
      end
    end
end
