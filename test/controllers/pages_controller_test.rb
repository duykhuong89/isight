require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get algorithm" do
    get :algorithm
    assert_response :success
  end

end
