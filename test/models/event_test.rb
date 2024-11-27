# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :datetime         not null
#  end_date    :datetime         not null
#  description :text
#  end_time    :datetime         not null
#  location    :string           not null
#  start_time  :datetime         not null
#  title       :string           not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    @event = Event.new(
      title: "Sample Event",
      start_date: Time.current + 1.day,
      end_date: Time.current + 2.days,
      start_time: Time.current + 1.day + 2.hours,
      end_time: Time.current + 1.day + 4.hours,
      location: "Sample Location",
      description: "Sample Description",
      user_id: @user.id
    )
  end

  test "should be valid with all attributes" do
    assert @event.valid?
  end

  test "should require a title" do
    @event.title = nil
    assert_not @event.valid?
    assert_includes @event.errors[:title], "can't be blank"
  end

  test "should require a start_time" do
    @event.start_time = nil
    assert_not @event.valid?
    assert_includes @event.errors[:start_time], "can't be blank"
  end

  test "should require an end_time" do
    @event.end_time = nil
    assert_not @event.valid?
    assert_includes @event.errors[:end_time], "can't be blank"
  end

  test "should require a location" do
    @event.location = nil
    assert_not @event.valid?
    assert_includes @event.errors[:location], "can't be blank"
  end

  test "should be invalid if start_date is in the past" do
    @event.start_date = Time.current - 1.day
    assert_not @event.valid?
    assert_includes @event.errors[:start_date], "must be in the future"
  end

  test "should be invalid if end_date is before start_date" do
    @event.end_date = @event.start_date - 1.day
    assert_not @event.valid?
    assert_includes @event.errors[:end_date], "must be after start date"
  end
end
