# == Schema Information
#
# Table name: guests
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  party_size      :integer
#  password_digest :string           default(""), not null
#  phone           :string
#  event_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Guest < ApplicationRecord
    has_secure_password

    belongs_to :guest_list
    belongs_to :events, through: :guest_lists
    belongs_to :user

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }

    enum role: { guest: "guest", admin: "admin" }
    enum rsvp_status: { pending: "pending", accepted: "accepted", declined: "declined" }
end
