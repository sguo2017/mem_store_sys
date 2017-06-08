require 'test_helper'

class Admin::ScoreHistoriesControllerTest < ActionController::TestCase
  setup do
    @score_history = score_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:score_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create score_history" do
    assert_difference('ScoreHistory.count') do
      post :create, score_history: { object_id: @score_history.object_id, object_type: @score_history.object_type, oper: @score_history.oper, point: @score_history.point, user_id: @score_history.user_id }
    end

    assert_redirected_to admin_score_history_path(assigns(:score_history))
  end

  test "should show score_history" do
    get :show, id: @score_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @score_history
    assert_response :success
  end

  test "should update score_history" do
    patch :update, id: @score_history, score_history: { object_id: @score_history.object_id, object_type: @score_history.object_type, oper: @score_history.oper, point: @score_history.point, user_id: @score_history.user_id }
    assert_redirected_to admin_score_history_path(assigns(:score_history))
  end

  test "should destroy score_history" do
    assert_difference('ScoreHistory.count', -1) do
      delete :destroy, id: @score_history
    end

    assert_redirected_to admin_score_histories_path
  end
end
