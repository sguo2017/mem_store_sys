require 'test_helper'

class Admin::GoodsCatalogsControllerTest < ActionController::TestCase
  setup do
    @goods_catalog = goods_catalogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goods_catalogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goods_catalog" do
    assert_difference('GoodsCatalog.count') do
      post :create, goods_catalog: { code: @goods_catalog.code, name: @goods_catalog.name }
    end

    assert_redirected_to admin_goods_catalog_path(assigns(:goods_catalog))
  end

  test "should show goods_catalog" do
    get :show, id: @goods_catalog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goods_catalog
    assert_response :success
  end

  test "should update goods_catalog" do
    patch :update, id: @goods_catalog, goods_catalog: { code: @goods_catalog.code, name: @goods_catalog.name }
    assert_redirected_to admin_goods_catalog_path(assigns(:goods_catalog))
  end

  test "should destroy goods_catalog" do
    assert_difference('GoodsCatalog.count', -1) do
      delete :destroy, id: @goods_catalog
    end

    assert_redirected_to admin_goods_catalogs_path
  end
end
