class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum platform: [:Steam, :PSN, :Xbox]

  has_many :items, class_name: 'UserItem', inverse_of: :user

  validates :platform_username, presence: true, length: { maximum: 32 }, uniqueness: { scope: :platform }
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
