require 'test_helper'

class ShopFavoritesControllerTest < ActionController::TestCase
  setup do
    @shop_favorite = shop_favorites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_favorites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_favorite" do
    assert_difference('ShopFavorite.count') do
      post :create, shop_favorite: { shop_id: @shop_favorite.shop_id, user_id: @shop_favorite.user_id }
    end

    assert_redirected_to shop_favorite_path(assigns(:shop_favorite))
  end

  test "should show shop_favorite" do
    get :show, id: @shop_favorite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_favorite
    assert_response :success
  end

  test "should update shop_favorite" do
    patch :update, id: @shop_favorite, shop_favorite: { shop_id: @shop_favorite.shop_id, user_id: @shop_favorite.user_id }
    assert_redirected_to shop_favorite_path(assigns(:shop_favorite))
  end

  test "should destroy shop_favorite" do
    assert_difference('ShopFavorite.count', -1) do
      delete :destroy, id: @shop_favorite
    end

    assert_redirected_to shop_favorites_path
  end
end
