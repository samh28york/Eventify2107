require "test_helper"

class GuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = Guest.create(email: "guest@example.com", password: "password", password_confirmation: "password")
    @event = Event.create(title: "Test Event", date: DateTime.now, location: "Test Location")
    @guest_list = GuestList.create(guest: @user, event: @event, rsvp_status: "pending")

    # Simulate login
    post login_url, params: { email: @user.email, password: @user.password }
  end

  test "should get index" do
    get guests_url
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should update attendance" do
    patch update_attendance_guest_url(@event), params: { event_id: @event.id, rsvp_status: "yes" }
    assert_redirected_to guest_home_path
    assert_equal "yes", @guest_list.reload.rsvp_status
    assert_not flash[:alert]
  end

  test "should fail to update attendance with invalid rsvp_status" do
    patch update_attendance_guest_url(@event), params: { event_id: @event.id, rsvp_status: "invalid_status" }
    assert_redirected_to guest_home_path
    assert flash[:alert]
  end

  test "should destroy event from guest dashboard" do
    assert_difference("GuestList.count", -1) do
      delete guest_url(@event)
    end
    assert_redirected_to guests_path
    assert_not flash[:alert]
  end
end
