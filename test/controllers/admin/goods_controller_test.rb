require 'test_helper'

class Admin::GoodsControllerTest < ActionController::TestCase
  setup do
    @good = goods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good" do
    assert_difference('Good.count') do
      post :create, good: { avatar: @good.avatar, code: @good.code, goods_catalog: @good.goods_catalog, ispromotion: @good.ispromotion, name: @good.name, score: @good.score, spec: @good.spec, status: @good.status }
    end

    assert_redirected_to admin_good_path(assigns(:good))
  end

  test "should show good" do
    get :show, id: @good
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @good
    assert_response :success
  end

  test "should update good" do
    patch :update, id: @good, good: { avatar: @good.avatar, code: @good.code, goods_catalog: @good.goods_catalog, ispromotion: @good.ispromotion, name: @good.name, score: @good.score, spec: @good.spec, status: @good.status }
    assert_redirected_to admin_good_path(assigns(:good))
  end

  test "should destroy good" do
    assert_difference('Good.count', -1) do
      delete :destroy, id: @good
    end

    assert_redirected_to admin_goods_path
  end
end
