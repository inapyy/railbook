require 'test_helper'

class FunCommentsControllerTest < ActionController::TestCase
  setup do
    @fun_comment = fun_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fun_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fun_comment" do
    assert_difference('FunComment.count') do
      post :create, :fun_comment => @fun_comment.attributes
    end

    assert_redirected_to fun_comment_path(assigns(:fun_comment))
  end

  test "should show fun_comment" do
    get :show, :id => @fun_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fun_comment.to_param
    assert_response :success
  end

  test "should update fun_comment" do
    put :update, :id => @fun_comment.to_param, :fun_comment => @fun_comment.attributes
    assert_redirected_to fun_comment_path(assigns(:fun_comment))
  end

  test "should destroy fun_comment" do
    assert_difference('FunComment.count', -1) do
      delete :destroy, :id => @fun_comment.to_param
    end

    assert_redirected_to fun_comments_path
  end
end
