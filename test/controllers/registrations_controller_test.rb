require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new_guest" do
    get new_guest_url
    assert_response :success
  end

  test "should get new_organizer" do
    get new_organizer_url
    assert_response :success
  end

  test "should create guest and redirect to guest home" do
    # Use inline data to create a guest
    guest_params = { email: "guest@example.com", password: "password123", password_confirmation: "password123" }

    assert_difference("Guest.count", 1) do
      post create_guest_url, params: { guest: guest_params }
    end
    guest = Guest.last
    assert_redirected_to guest_home_path
    assert_equal "Guest account created successfully.", flash[:notice]
    assert_equal guest.id, session[:guest_id]
  end

  test "should not create guest and render new_guest if invalid" do
    # Invalid data with missing email
    guest_params = { email: "", password: "password123", password_confirmation: "password123" }

    assert_no_difference("Guest.count") do
      post create_guest_url, params: { guest: guest_params }
    end
    assert_template :new_guest
  end

  test "should create organizer and redirect to organizer home" do
    # Use inline data to create an organizer
    organizer_params = { email: "organizer@example.com", password: "password123", password_confirmation: "password123" }

    assert_difference("Organizer.count", 1) do
      post create_organizer_url, params: { organizer: organizer_params }
    end
    organizer = Organizer.last
    assert_redirected_to organizer_home_path
    assert_equal "Organizer account created successfully.", flash[:notice]
    assert_equal organizer.id, session[:organizer_id]
  end

  test "should not create organizer and render new_organizer if invalid" do
    # Invalid data with missing email
    organizer_params = { email: "", password: "password123", password_confirmation: "password123" }

    assert_no_difference("Organizer.count") do
      post create_organizer_url, params: { organizer: organizer_params }
    end
    assert_template :new_organizer
  end
end
