require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # Test for rendering guest login form
  test "should get new_guest" do
    get new_guest_url
    assert_response :success
  end

  # Test for successful guest login
  test "should log in guest and redirect to guest home" do
    # Create a guest instance with valid attributes
    guest = Guest.create(email: "guest@example.com", password: "password123", password_confirmation: "password123")

    post create_guest_url, params: { email: guest.email, password: "password123" }

    assert_redirected_to guest_home_path
    assert_equal "Logged in successfully.", flash[:notice]
    assert_equal guest.id, session[:guest_id]
  end

  # Test for failed guest login
  test "should not log in guest and render new_guest if invalid" do
    guest = Guest.create(email: "guest@example.com", password: "password123", password_confirmation: "password123")

    post create_guest_url, params: { email: guest.email, password: "wrongpassword" }

    assert_template :new_guest
    assert_equal "Invalid email or password", flash.now[:alert]
  end
end
