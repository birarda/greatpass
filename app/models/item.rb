# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  kind       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rarity     :integer          default("common")
#

class Item < ApplicationRecord
  enum kind: [:topper, :antenna, :wheels, :boost, :decal, :crate, 'battle-car']
  enum rarity: [:common, :uncommon, :rare, :super_rare, :premium, :limited, :very_rare, :import, :exotic, :black_market]

  has_many :user_items, inverse_of: :item

  validates :name, uniqueness: { scope: :kind, case_sensitive: false }

  def self.default_scope
    order(name: :asc)
  end
end
