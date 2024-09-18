require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = @user = User.create!(
      email: "unique_#{Time.now.to_i}@example.com",
      password: "password123",
      password_confirmation: "password"
    )
  end

  test "should create session with valid credentials" do
    post "/users/login", params: { email: @user.email, password: "password" }
    assert_response :success
    assert_not_nil JSON.parse(response.body)["token"]
  end

  test "should not create session with invalid credentials" do
    post "/users/login", params: { email: @user.email, password: "wrong_password" }
    assert_response :unauthorized
  end

  test "should destroy session" do
    # First, create a session
    post "/users/login", params: { email: @user.email, password: "password" }
    token = JSON.parse(response.body)["token"]

    # Then, destroy the session
    delete "/users/logout", headers: { "Authorization" => "Bearer #{token}" }
    assert_response :success
  end

  test "should not destroy session without authentication" do
    delete "/users/logout"
    assert_response :unauthorized
  end
end
