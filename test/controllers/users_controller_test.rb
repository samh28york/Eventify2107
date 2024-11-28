require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create test data
    @user = User.create!(
      email: 'testuser@example.com',
      password: 'password',
      first_name: 'Test',
      last_name: 'User'
    )
  end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
    assert_select 'form' # Ensure form is rendered
  end

  test "should create user with valid data" do
    assert_difference('User.count', 1) do
      post user_registrations_path, params: {
        user: {
          email: 'newuser@example.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'New',
          last_name: 'User'
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match 'Account created successfully.', response.body
  end

  private

  def sign_in(user)
    post user_sessions_path, params: { email: user.email, password: 'password' }
  end

  def sign_out(user)
    delete logout_path
  end
end