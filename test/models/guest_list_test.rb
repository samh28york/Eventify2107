# == Schema Information
#
# Table name: guest_lists
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  guest_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class GuestListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
