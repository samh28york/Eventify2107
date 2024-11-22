# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :datetime
#  end_date    :datetime
#  description :text
#  end_time    :datetime
#  location    :string
#  start_time  :datetime
#  title       :string
#  creator_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location, presence: true

  validate :date_must_be_in_the_future
  validate :end_date_be_equal_to_or_after_start_date

  private

  def date_must_be_in_the_future
    if start_date.present? && start_date < Time.current
      errors.add(:start_date, "must be in the future")
    end
  end

  def end_date_be_equal_to_or_after_start_date
    if end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
