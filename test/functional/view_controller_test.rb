require 'test_helper'

class ViewControllerTest < ActionController::TestCase
  test "should get keyword" do
    get :keyword
    assert_response :success
  end

end
