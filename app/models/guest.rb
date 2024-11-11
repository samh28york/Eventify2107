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
    has_many :guest_lists, dependent: :destroy
    has_many :events, through: :guest_lists
    has_many :gift_registries
    has_many :gifts, through: :gift_registries

    has_and_belongs_to_many :events

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
end
