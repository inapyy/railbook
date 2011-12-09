require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "login test" do
    get '/hello/view'
    assert_response :redirect
    assert_redirected_to :controller => 'login', :action => 'index'
    assert_equal '/hello/view', flash[:referer]

    follow_redirect!
    assert_response :success
    assert_equal '/hello/view', flash[:referer]

    post '/login/auth', { :username => 'yyamada', :password => '12345',
      :referer => '/hello/view' }
    assert_response :redirect
    assert_redirected_to :controller => 'hello', :action => 'view'
    assert_equal users(:yyamada).id, session[:usr]

    follow_redirect!
    assert_response :success

    # post_via_redirect '/login/auth', { :username => 'yyamada',
    #   :password => '12345', :referer => '/hello/view' }
    # assert_response :success

  end

end
