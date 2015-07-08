require 'test_helper'

class BssControllerTest < ActionController::TestCase
  test "should get men" do
    get :men
    assert_response :success
  end

  test "should get women" do
    get :women
    assert_response :success
  end

  test "should get interior" do
    get :interior
    assert_response :success
  end
  
end
