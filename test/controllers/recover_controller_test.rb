require 'test_helper'

class RecoverControllerTest < ActionController::TestCase
  test "should get recover" do
    get :recover
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
