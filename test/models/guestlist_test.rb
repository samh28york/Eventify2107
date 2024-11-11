# test/models/guestlist_test.rb
require "test_helper"

class GuestlistTest < ActiveSupport::TestCase
  # Test that a guestlist belongs to a guest
  test "should belong to guest" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    
    guestlist = Guestlist.new(guest_id: guest.id, event_id: event.id)
    assert_respond_to guestlist, :guest
  end

  # Test that a guestlist belongs to an event
  test "should belong to event" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    
    guestlist = Guestlist.new(guest_id: guest.id, event_id: event.id)
    assert_respond_to guestlist, :event
  end

  # Test that guestlist is valid with correct data
  test "should be valid with guest_id and event_id" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    
    guestlist = Guestlist.new(guest_id: guest.id, event_id: event.id)
    assert guestlist.valid?
  end

  # Test that guestlist is invalid without guest_id
  test "should be invalid without guest_id" do
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    guestlist = Guestlist.new(event_id: event.id)
    assert_not guestlist.valid?
    assert_includes guestlist.errors[:guest_id], "can't be blank"
  end

  # Test that guestlist is invalid without event_id
  test "should be invalid without event_id" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    guestlist = Guestlist.new(guest_id: guest.id)
    assert_not guestlist.valid?
    assert_includes guestlist.errors[:event_id], "can't be blank"
  end

  # Test that the guestlist is destroyed when the guest is destroyed
  test "should destroy guestlist when guest is destroyed" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    guestlist = guest.guestlists.create(event_id: event.id)
    
    assert_difference('Guestlist.count', -1) do
      guest.destroy
    end
  end

  # Test that the guestlist is destroyed when the event is destroyed
  test "should destroy guestlist when event is destroyed" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    guestlist = event.guestlists.create(guest_id: guest.id)
    
    assert_difference('Guestlist.count', -1) do
      event.destroy
    end
  end

  # Test the RSVP status field
  test "should accept valid rsvp_status" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    
    guestlist = Guestlist.new(guest_id: guest.id, event_id: event.id, rsvp_status: "Accepted")
    assert guestlist.valid?
  end

  test "should not accept invalid rsvp_status" do
    guest = Guest.create(email: "guest@example.com", password: "password", first_name: "John", last_name: "Doe")
    event = Event.create(title: "Sample Event", start_time: Time.now, end_time: Time.now + 2.hours, location: "Sample Location")
    
    guestlist = Guestlist.new(guest_id: guest.id, event_id: event.id, rsvp_status: "Maybe")
    assert_not guestlist.valid?
  end
end
