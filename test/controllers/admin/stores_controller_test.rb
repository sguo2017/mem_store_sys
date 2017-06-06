require 'test_helper'

class Admin::StoresControllerTest < ActionController::TestCase
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, store: { addr: @store.addr, catalog: @store.catalog, city: @store.city, code: @store.code, contact_num: @store.contact_num, country: @store.country, district: @store.district, latitude: @store.latitude, linkman: @store.linkman, longitude: @store.longitude, name: @store.name, province: @store.province }
    end

    assert_redirected_to admin_store_path(assigns(:store))
  end

  test "should show store" do
    get :show, id: @store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store
    assert_response :success
  end

  test "should update store" do
    patch :update, id: @store, store: { addr: @store.addr, catalog: @store.catalog, city: @store.city, code: @store.code, contact_num: @store.contact_num, country: @store.country, district: @store.district, latitude: @store.latitude, linkman: @store.linkman, longitude: @store.longitude, name: @store.name, province: @store.province }
    assert_redirected_to admin_store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, id: @store
    end

    assert_redirected_to admin_stores_path
  end
end
