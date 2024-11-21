require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  # Test for the index page
  test "should get index" do
    get root_url
    assert_response :success
  end

  # Test for guest home page with events
  test "should get guest_home with events" do
    guest = Guest.create(email: "guest@example.com", password: "password123", password_confirmation: "password123")
    event = Event.create(title: "Event 1", description: "Sample event", start_time: Time.current, end_time: Time.current + 1.hour)
    guest_list = GuestList.create(guest: guest, event: event)

    # Simulate the guest login
    sign_in guest

    get guest_home_url

    assert_response :success
    assert_includes assigns(:events), event
  end

  # Test for guest home page with no events
  test "should get guest_home with no events" do
    guest = Guest.create(email: "guest@example.com", password: "password123", password_confirmation: "password123")

    # Simulate the guest login
    sign_in guest

    get guest_home_url

    assert_response :success
    assert_empty assigns(:events)
  end

  private

  # Helper method for simulating user sign-in
  def sign_in(user)
    post session_url, params: { email: user.email, password: user.password }
  end
end
