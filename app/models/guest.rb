# == Schema Information
#
# Table name: guests
#
#  id          :integer          not null, primary key
#  role        :string           default("guest")
#  rsvp_status :string           default("pending")
#  party_size  :integer
#  event_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Guest < ApplicationRecord
    belongs_to :event
    belongs_to :user

    enum role: { guest: "guest", admin: "admin" }
    enum rsvp_status: { pending: "pending", accepted: "accepted", declined: "declined" }
end
