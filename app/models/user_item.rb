# == Schema Information
#
# Table name: user_items
#
#  id            :integer          not null, primary key
#  item_id       :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  paint_color   :integer
#  certification :integer
#  list          :integer
#

class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  enum list: [
    :inventory,
    :wishlist
  ]

  enum certification: [
    :acrobat,
    :aviator,
    :goalkeeper,
    :guardian,
    :juggler,
    :paragon,
    :playmaker,
    :scorer,
    'show-off',
    :sniper,
    :striker,
    :sweeper,
    :tactician,
    :turtle,
    :victor
  ]

  enum paint_color: [
    :black,
    :burnt_sienna,
    :cobalt,
    :crimson,
    :forest_green,
    :grey,
    :lime,
    :pink,
    :purple,
    :saffron,
    :sky_blue,
    :titanium_white,
    :orange
  ]

  attr_accessor :certified
  attr_accessor :painted

  validates :item_id, presence: true
  # validates_uniqueness_of :item_id, scope: [:certification, :paint_color], message: 'is already in your inventory'
  validate :common_is_special

  def to_s
    "#{self.paint_color ? self.paint_color.titleize + ' ' : ''}#{self.certification ? self.certification.capitalize + ' ' : ''}#{self.item.name}"
  end

  def owned_percentage
    Rails.cache.fetch("#{self.to_s}/owned_percentage", expires_in: 5.minutes) do
      total_item_count = UserItem.where(item_id: self.item_id, certification: self.certification, paint_color: self.paint_color)
                                 .count('DISTINCT user_id')
                                 
      return 0 if total_item_count == 0

      total_users = User.count

      return 100 * (total_item_count.to_f / total_users)
    end
  end

  private

    def common_is_special
      if self.item && self.item.common? && (self.certification.nil? && self.paint_color.nil?)
        errors.add(:item_id, "that is common is only tradeable if it is painted or certified")
      end
    end
end
