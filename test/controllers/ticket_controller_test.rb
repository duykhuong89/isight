require 'test_helper'

class TicketControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
