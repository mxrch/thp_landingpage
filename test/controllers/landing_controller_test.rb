require 'test_helper'

class LandingControllerTest < ActionDispatch::IntegrationTest
  test "should get one" do
    get landing_one_url
    assert_response :success
  end

  test "should get two" do
    get landing_two_url
    assert_response :success
  end

  test "should get three" do
    get landing_three_url
    assert_response :success
  end

end
