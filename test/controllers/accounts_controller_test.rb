require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get address" do
    get :address
    assert_response :success
  end

  test "should get addaddress" do
    get :addaddress
    assert_response :success
  end

  test "should get orders" do
    get :orders
    assert_response :success
  end

  test "should get singleorder" do
    get :singleorder
    assert_response :success
  end

  test "should get wishlist" do
    get :wishlist
    assert_response :success
  end

  test "should get warranty" do
    get :warranty
    assert_response :success
  end

end
