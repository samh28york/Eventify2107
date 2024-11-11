# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :datetime
#  description :text
#  end_time    :datetime
#  location    :string
#  start_time  :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
    has_one :guest_list, dependent: :destroy
    has_and_belongs_to_many :guests, dependent: :destroy

    validates :title, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :location, presence: true

    validate :date_must_be_in_the_future

    private

    def date_must_be_in_the_future
        if date.present? && date < Time.current
          errors.add(:date, "must be in the future")
        end
      end
end
