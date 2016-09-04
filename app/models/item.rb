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
  enum kind: [:topper, :antenna, :wheels, :boost, :decal]
  enum rarity: [:common, :uncommon, :rare, :super_rare, :premium, :limited]
end
