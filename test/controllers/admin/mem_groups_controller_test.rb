require 'test_helper'

class Admin::MemGroupsControllerTest < ActionController::TestCase
  setup do
    @mem_group = mem_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mem_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mem_group" do
    assert_difference('MemGroup.count') do
      post :create, mem_group: { city: @mem_group.city, country: @mem_group.country, province: @mem_group.province }
    end

    assert_redirected_to admin_mem_group_path(assigns(:mem_group))
  end

  test "should show mem_group" do
    get :show, id: @mem_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mem_group
    assert_response :success
  end

  test "should update mem_group" do
    patch :update, id: @mem_group, mem_group: { city: @mem_group.city, country: @mem_group.country, province: @mem_group.province }
    assert_redirected_to admin_mem_group_path(assigns(:mem_group))
  end

  test "should destroy mem_group" do
    assert_difference('MemGroup.count', -1) do
      delete :destroy, id: @mem_group
    end

    assert_redirected_to admin_mem_groups_path
  end
end
