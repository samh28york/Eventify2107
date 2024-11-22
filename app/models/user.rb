# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           default(""), not null
#  first_name      :string
#  last_name       :string
#  phone_number    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_secure_password

    has_many :guests, dependent: :destroy
    has_many :events_as_admin, -> { where(guests: { role: "admin" }) }, through: :guests, source: :event
    has_many :events_as_guest, -> { where(guests: { role: "guest" }) }, through: :guests, source: :event

    has_many :created_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
end
