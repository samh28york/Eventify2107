# == Schema Information
#
# Table name: guest_lists
#
#  id          :integer          not null, primary key
#  rsvp_status :string
#  event_id    :integer          not null
#  guest_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class GuestListTest < ActiveSupport::TestCase
  # Test that a GuestList belongs to a guest
  test "should belong to guest" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")

    GuestList = GuestList.new(guest_id: guest.id, event_id: event.id)
    assert_respond_to GuestList, :guest
  end

  # Test that a GuestList belongs to an event
  test "should belong to event" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")

    GuestList = GuestList.new(guest_id: guest.id, event_id: event.id)
    assert_respond_to GuestList, :event
  end

  # Test that GuestList is valid with correct data
  test "should be valid with guest_id and event_id" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")

    GuestList = GuestList.new(guest_id: guest.id, event_id: event.id)
    assert GuestList.valid?
  end

  # Test that GuestList is invalid without guest_id
  test "should be invalid without guest_id" do
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    GuestList = GuestList.new(event_id: event.id)
    assert_not GuestList.valid?
    assert_includes GuestList.errors[:guest_id], "can't be blank"
  end

  # Test that GuestList is invalid without event_id
  test "should be invalid without event_id" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    GuestList = GuestList.new(guest_id: guest.id)
    assert_not GuestList.valid?
    assert_includes GuestList.errors[:event_id], "can't be blank"
  end

  # Test that the GuestList is destroyed when the guest is destroyed
  test "should destroy GuestList when guest is destroyed" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    GuestList = guest.guestlists.create(event_id: event.id)

    assert_difference("GuestList.count", -1) do
      guest.destroy
    end
  end

  # Test that the GuestList is destroyed when the event is destroyed
  test "should destroy GuestList when event is destroyed" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    GuestList = event.guestlists.create(guest_id: guest.id)

    assert_difference("GuestList.count", -1) do
      event.destroy
    end
  end

  # Test the RSVP status field
  test "should accept valid rsvp_status" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")

    GuestList = GuestList.new(guest_id: guest.id, event_id: event.id, rsvp_status: "Accepted")
    assert GuestList.valid?
  end

  test "should not accept invalid rsvp_status" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")

    GuestList = GuestList.new(guest_id: guest.id, event_id: event.id, rsvp_status: "Maybe")
    assert_not GuestList.valid?
  end
end
