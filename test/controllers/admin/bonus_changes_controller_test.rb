require 'test_helper'

class Admin::BonusChangesControllerTest < ActionController::TestCase
  setup do
    @bonus_change = bonus_changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bonus_changes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bonus_change" do
    assert_difference('BonusChange.count') do
      post :create, bonus_change: { red_packet: @bonus_change.red_packet, score: @bonus_change.score }
    end

    assert_redirected_to admin_bonus_change_path(assigns(:bonus_change))
  end

  test "should show bonus_change" do
    get :show, id: @bonus_change
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bonus_change
    assert_response :success
  end

  test "should update bonus_change" do
    patch :update, id: @bonus_change, bonus_change: { red_packet: @bonus_change.red_packet, score: @bonus_change.score }
    assert_redirected_to admin_bonus_change_path(assigns(:bonus_change))
  end

  test "should destroy bonus_change" do
    assert_difference('BonusChange.count', -1) do
      delete :destroy, id: @bonus_change
    end

    assert_redirected_to admin_bonus_changes_path
  end
end
