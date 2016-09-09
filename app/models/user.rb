# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  platform               :integer
#  platform_username      :string
#  platform_url           :string
#  admin                  :boolean          default(FALSE)
#  reddit_username        :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum platform: [:Steam, :PSN, :Xbox]

  has_many :items, class_name: 'UserItem', inverse_of: :user
  has_many :inventory, -> { where('user_items.list = ?', UserItem.lists[:inventory]) }, class_name: 'UserItem', inverse_of: :user
  has_many :wishlist, -> { where('user_items.list = ?', UserItem.lists[:wishlist]) }, class_name: 'UserItem', inverse_of: :user

  validates :platform_username, presence: true, length: { maximum: 32 }, uniqueness: { scope: :platform, case_sensitive: false }
  validates :platform, presence: true
  validates :platform_url, url: { no_local: true, allow_nil: true, allow_blank: true }

  before_validation :smart_add_platform_url_protocol

  protected

  def smart_add_platform_url_protocol
    unless self.platform_url.blank? || self.platform_url[/\Ahttp:\/\//] || self.platform_url[/\Ahttps:\/\//]
      self.platform_url = "http://#{self.platform_url}"
    end
  end
end
