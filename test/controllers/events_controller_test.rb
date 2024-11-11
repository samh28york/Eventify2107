require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
     # Create an event with valid attributes
     @event = Event.create!(
      title: "Test Event",
      date: DateTime.now + 1.day,  # Future date
      start_time: DateTime.now + 1.day + 2.hours,
      end_time: DateTime.now + 1.day + 4.hours,
      location: "Test Location",
      description: "Test Description"
    )

    # Create a guest with valid attributes
    @guest = Guest.create!(
      email: "guest@example.com",
      password: "password"
    )
  end

  test "should get index" do
    get events_url
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:guests)
  end

  test "should create event" do
    assert_difference("Event.count") do
      post events_url, params: { event: { title: "New Event", date: DateTime.now, start_time: DateTime.now, end_time: DateTime.now + 1.hour, location: "Location", description: "Description" } }
    end

    assert_redirected_to event_url(Event.last)
    assert_equal "Event was successfully created", flash[:notice]
  end

  test "should not create event with invalid data" do
    post events_url, params: { event: { title: "" } }  # Invalid event params
    assert_response :unprocessable_entity
    assert_template :new
    assert_includes flash[:alert], "Failed to create event"
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
    assert_not_nil assigns(:event)
  end

  test "should update event" do
    patch event_url(@event), params: { event: { title: "Updated Title" } }
    assert_redirected_to event_url(@event)
    assert_equal "Event was successfully updated.", flash[:notice]
    assert_equal "Updated Title", @event.reload.title
  end

  test "should not update event with invalid data" do
    patch event_url(@event), params: { event: { title: "" } }  # Invalid data
    assert_response :unprocessable_entity
    assert_template :edit
  end

  test "should destroy event" do
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
    assert_equal "Event was successfully deleted.", flash[:notice]
  end

  test "should not destroy event if not deletable" do
    Event.any_instance.stubs(:destroy!).raises(ActiveRecord::RecordNotDestroyed)  # Simulate destroy failure
    delete event_url(@event)

    assert_redirected_to events_url
    assert_match "Event could not be deleted", flash[:alert]
  end

  test "should add guest to event" do
    assert_difference("@event.guests.count", 1) do
      post add_guest_event_url(@event), params: { guest: { name: @guest.name, email: @guest.email } }
    end

    assert_redirected_to event_url(@event)
    assert_equal "Guest was successfully added to the event.", flash[:notice]
  end

  test "should not add invalid guest to event" do
    post add_guest_event_url(@event), params: { guest: { name: "", email: "" } }  # Invalid guest data
    assert_redirected_to event_url(@event)
    assert_includes flash[:alert], "Failed to add guest to the event"
  end
end
