require 'test_helper'

class Admin::GoodInstancesControllerTest < ActionController::TestCase
  setup do
    @good_instance = good_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:good_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good_instance" do
    assert_difference('GoodInstance.count') do
      post :create, good_instance: { code: @good_instance.code, good_id: @good_instance.good_id, status: @good_instance.status }
    end

    assert_redirected_to admin_good_instance_path(assigns(:good_instance))
  end

  test "should show good_instance" do
    get :show, id: @good_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @good_instance
    assert_response :success
  end

  test "should update good_instance" do
    patch :update, id: @good_instance, good_instance: { code: @good_instance.code, good_id: @good_instance.good_id, status: @good_instance.status }
    assert_redirected_to admin_good_instance_path(assigns(:good_instance))
  end

  test "should destroy good_instance" do
    assert_difference('GoodInstance.count', -1) do
      delete :destroy, id: @good_instance
    end

    assert_redirected_to admin_good_instances_path
  end
end
