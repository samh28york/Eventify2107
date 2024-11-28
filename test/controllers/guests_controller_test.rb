require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data instead of using fixtures
    @admin_user = User.create!(email: 'admin@example.com', password: 'password', first_name: 'Admin', last_name: 'User')
    @guest_user = User.create!(email: 'guest@example.com', password: 'password', first_name: 'Guest', last_name: 'User')

    @event = Event.create!(
      title: 'Test Event',
      start_date: 1.day.from_now,
      end_date: 2.days.from_now,
      start_time: Time.current + 1.hour,
      end_time: Time.current + 2.hours,
      location: 'Test Location',
      user: @admin_user
    )

    @guest = Guest.create!(
      user: @guest_user,
      event: @event,
      role: "guest",
      rsvp_status: "pending"
    )

    sign_in @admin_user
  end

  test "should get index" do
    get event_path(@event)
    assert_response :success
    assert_equal assigns(:guests), @event.guests
  end

  test "should create guest" do
    assert_difference('Guest.count', 1) do
      post event_guests_path(@event), params: {
        guest: {
          user_id: @guest_user.id,
          role: "guest"
        }
      }
    end
  
    assert_redirected_to event_path(@event)
    follow_redirect!
    assert_match "Guest successfully created.", response.body
  end

  test "should destroy guest" do
    assert_difference('Guest.count', -1) do
      delete event_guest_path(@event, @guest)
    end

    assert_redirected_to event_path(@event)
  end

  private

  def sign_in(user)
    post user_sessions_path, params: { email: user.email, password: 'password' }
  end

  def sign_out(user)
    delete destroy_user_session_path
  end
end