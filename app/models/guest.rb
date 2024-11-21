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
    has_secure_password

    belongs_to :events
    belongs_to :user

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }

    enum role: { guest: "guest", admin: "admin" }
    enum rsvp_status: { pending: "pending", accepted: "accepted", declined: "declined" }
end
