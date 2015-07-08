require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    frodo = users(:one)
    post :create, email: frodo.email, password: 'secret'
    assert_equal frodo.id, session[:user_id]
  end

  test "should fail login" do
    frodo = users(:one)
    post :create, email: frodo.email, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
  end

end
