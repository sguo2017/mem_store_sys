require 'test_helper'

class Admin::MemLevelsControllerTest < ActionController::TestCase
  setup do
    @mem_level = mem_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mem_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mem_level" do
    assert_difference('MemLevel.count') do
      post :create, mem_level: { code: @mem_level.code, district: @mem_level.district, name: @mem_level.name, score: @mem_level.score }
    end

    assert_redirected_to admin_mem_level_path(assigns(:mem_level))
  end

  test "should show mem_level" do
    get :show, id: @mem_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mem_level
    assert_response :success
  end

  test "should update mem_level" do
    patch :update, id: @mem_level, mem_level: { code: @mem_level.code, district: @mem_level.district, name: @mem_level.name, score: @mem_level.score }
    assert_redirected_to admin_mem_level_path(assigns(:mem_level))
  end

  test "should destroy mem_level" do
    assert_difference('MemLevel.count', -1) do
      delete :destroy, id: @mem_level
    end

    assert_redirected_to admin_mem_levels_path
  end
end
