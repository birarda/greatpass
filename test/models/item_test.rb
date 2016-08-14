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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
