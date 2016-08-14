# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  type       :integer          default("topper")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rarity     :integer
#

class Item < ApplicationRecord
  enum type: [:topper, :antenna, :wheels, :boost, :decal]
  enum rarity: [:common, :uncommon, :rare, :super_rare, :premium, :limited]
end
