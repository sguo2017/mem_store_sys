require 'test_helper'

class Admin::TechServsControllerTest < ActionController::TestCase
  setup do
    @tech_serv = tech_servs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tech_servs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tech_serv" do
    assert_difference('TechServ.count') do
      post :create, tech_serv: { content: @tech_serv.content }
    end

    assert_redirected_to admin_tech_serv_path(assigns(:tech_serv))
  end

  test "should show tech_serv" do
    get :show, id: @tech_serv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tech_serv
    assert_response :success
  end

  test "should update tech_serv" do
    patch :update, id: @tech_serv, tech_serv: { content: @tech_serv.content }
    assert_redirected_to admin_tech_serv_path(assigns(:tech_serv))
  end

  test "should destroy tech_serv" do
    assert_difference('TechServ.count', -1) do
      delete :destroy, id: @tech_serv
    end

    assert_redirected_to admin_tech_servs_path
  end
end
