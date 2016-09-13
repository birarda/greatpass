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
  has_many :deletions, class_name: 'UserConversationDeletion'

  has_one :last_message, ->{ order 'messages.created_At DESC' }, class_name: 'Message'
end
