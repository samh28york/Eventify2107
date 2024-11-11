# == Schema Information
#
# Table name: guestlists
#
#  id          :integer          not null, primary key
#  rsvp_status :string
#  event_id    :integer          not null
#  guest_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Guestlist < ApplicationRecord
    belongs_to :guests, dependent: :destroy
    belongs_to :event
end
