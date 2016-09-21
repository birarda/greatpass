# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  reset_password_token        :string
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :inet
#  last_sign_in_ip             :inet
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  platform                    :integer
#  platform_username           :string
#  platform_url                :string
#  admin                       :boolean          default(FALSE)
#  reddit_username             :string
#  signup_code                 :string
#  confirmation_token          :string
#  confirmed_at                :datetime
#  confirmation_sent_at        :datetime
#  unconfirmed_email           :string
#  email_notifications_enabled :boolean          default(FALSE)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  enum platform: [:Steam, :PSN, :Xbox]

  has_many :items, class_name: 'UserItem', inverse_of: :user
  has_many :inventory, -> { where('user_items.list = ?', UserItem.lists[:inventory]) }, class_name: 'UserItem', inverse_of: :user
  has_many :wishlist, -> { where('user_items.list = ?', UserItem.lists[:wishlist]) }, class_name: 'UserItem', inverse_of: :user

  validates :platform_username, presence: true, length: { maximum: 32 }, uniqueness: { scope: :platform, case_sensitive: false }, format: { without: /[\/]+/ }
  validates :reddit_username, uniqueness: { case_sensitive: false, allow_blank: true }
  validates :platform, presence: true
  validates :platform_url, url: { no_local: true, allow_nil: true, allow_blank: true }

  before_validation :smart_add_platform_url_protocol

  after_commit :send_pending_notifications
  after_create :send_manual_optional_confirmation_instructions

  def inbox
    Conversation.includes(:last_message, :sender, :receiver)
                .select("conversations.*, (SELECT count(*) from messages where conversation_id = conversations.id AND receiver_id = #{self.id} AND messages.read = 'f') as unread_count")
                .where('(receiver_id = ? AND receiver_deleted = ?) OR (sender_id = ? AND sender_deleted = ?)', self.id, false, self.id, false)
                .order('updated_at DESC')
  end

  def unread_message_count
     Message.where(receiver_id: self.id, read: false).count('DISTINCT conversation_id')
  end

  protected

  def smart_add_platform_url_protocol
    unless self.platform_url.blank? || self.platform_url[/\Ahttp:\/\//] || self.platform_url[/\Ahttps:\/\//]
      self.platform_url = "http://#{self.platform_url}"
    end
  end

  def confirmation_required?
    false
  end

  def send_manual_optional_confirmation_instructions
    self.skip_reconfirmation!
    self.send_confirmation_instructions
  end

  def send_devise_notification(notification, *args)
    # If the record is new or changed then delay the
    # delivery until the after_commit callback otherwise
    # send now because after_commit will not be called.
    if new_record? || changed?
      pending_notifications << [notification, args]
    else
      message = devise_mailer.send(notification, self, *args).deliver_later
    end
  end

  def send_pending_notifications
    pending_notifications.each do |notification, args|
      message = devise_mailer.send(notification, self, *args).deliver_later
    end

    # Empty the pending notifications array because the
    # after_commit hook can be called multiple times which
    # could cause multiple emails to be sent.
    pending_notifications.clear
  end

  def pending_notifications
    @pending_notifications ||= []
  end

end
