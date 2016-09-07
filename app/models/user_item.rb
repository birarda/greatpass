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

  private
    def only_one_kind
      if certification != nil && paint_color != nil
        errors.add(:kind, "an item can be certified or painted but not both")
      end
    end
end
