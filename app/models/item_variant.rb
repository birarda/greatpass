# == Schema Information
#
# Table name: item_variants
#
#  id                   :integer          not null, primary key
#  item_id              :integer
#  certification        :integer
#  paint_color          :integer
#  inventory_percentage :float
#  wishlist_percentage  :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ItemVariant < ApplicationRecord
end
