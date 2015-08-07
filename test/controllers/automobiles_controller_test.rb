require 'test_helper'

class AutomobilesControllerTest < ActionController::TestCase
  test "should get ads" do
    get :ads
    assert_response :success
  end

end
