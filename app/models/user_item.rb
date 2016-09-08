class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

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

  attr_accessor :kind

  validate :only_one_kind
  validates :item_id, presence: true
  # validates_uniqueness_of :item_id, scope: [:certification, :paint_color], message: 'is already in your inventory'
  validate :common_is_special

  def to_s
    if self.certification
      "#{self.certification.titleize} #{self.item.name.titleize}"
    elsif self.paint_color
      "#{self.paint_color.titleize} #{self.item.name.titleize}"
    else
      self.item.name
    end
  end

  private
    def only_one_kind
      if certification != nil && paint_color != nil
        errors.add(:kind, "an item can be certified or painted but not both")
      end
    end

    def common_is_special
      if self.item && self.item.common? && (self.certification.nil? && self.paint_color.nil?)
        errors.add(:item_id, "that is common is only tradeable if it is painted or certified")
      end
    end
end
