require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get checkout" do
    get :checkout
    assert_response :success
  end

  test "should get checkout_payment" do
    get :checkout_payment
    assert_response :success
  end

  test "should get checkout_review" do
    get :checkout_review
    assert_response :success
  end

end
