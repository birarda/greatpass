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

require 'test_helper'

class UserItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
