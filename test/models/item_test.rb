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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
