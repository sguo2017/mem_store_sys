require 'test_helper'

class Admin::LotteriesControllerTest < ActionController::TestCase
  setup do
    @lottery = lotteries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lotteries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lottery" do
    assert_difference('Lottery.count') do
      post :create, lottery: { activity_award_cfg_id: @lottery.activity_award_cfg_id, activity_award_cfg_name: @lottery.activity_award_cfg_name, activity_award_id: @lottery.activity_award_id, activity_id: @lottery.activity_id, activity_name: @lottery.activity_name, user_id: @lottery.user_id, winning: @lottery.winning }
    end

    assert_redirected_to admin_lottery_path(assigns(:lottery))
  end

  test "should show lottery" do
    get :show, id: @lottery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lottery
    assert_response :success
  end

  test "should update lottery" do
    patch :update, id: @lottery, lottery: { activity_award_cfg_id: @lottery.activity_award_cfg_id, activity_award_cfg_name: @lottery.activity_award_cfg_name, activity_award_id: @lottery.activity_award_id, activity_id: @lottery.activity_id, activity_name: @lottery.activity_name, user_id: @lottery.user_id, winning: @lottery.winning }
    assert_redirected_to admin_lottery_path(assigns(:lottery))
  end

  test "should destroy lottery" do
    assert_difference('Lottery.count', -1) do
      delete :destroy, id: @lottery
    end

    assert_redirected_to admin_lotteries_path
  end
end
