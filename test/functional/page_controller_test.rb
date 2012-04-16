require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get hire" do
    get :hire
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get managecontracts" do
    get :managecontracts
    assert_response :success
  end

  test "should get usercontracts" do
    get :usercontracts
    assert_response :success
  end

end
