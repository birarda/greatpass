# == Schema Information
#
# Table name: conversations
#
#  id               :integer          not null, primary key
#  subject          :string
#  sender_id        :integer
#  receiver_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  receiver_deleted :boolean          default(FALSE)
#  sender_deleted   :boolean          default(FALSE)
#

class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, inverse_of: :conversation

  has_one :last_message, ->{ order 'messages.created_At DESC' }, class_name: 'Message'

  validate :not_note_to_self

  def other_user(this_user)
    (this_user.id == self.sender_id) ? self.receiver : self.sender
  end

  def subject_or_fallback
    self.subject.blank? ? "(no subject)" : self.subject
  end

  private
    def not_note_to_self
      if self.sender_id == self.receiver_id
        errors.add(:thread, 'cannot be started with yourself')
      end
    end
end
