require 'test_helper'

class DishCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dish_category = dish_categories(:one)
  end

  test "should get index" do
    get dish_categories_url, as: :json
    assert_response :success
  end

  test "should create dish_category" do
    assert_difference('DishCategory.count') do
      post dish_categories_url, params: { dish_category: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show dish_category" do
    get dish_category_url(@dish_category), as: :json
    assert_response :success
  end

  test "should update dish_category" do
    patch dish_category_url(@dish_category), params: { dish_category: {  } }, as: :json
    assert_response 200
  end

  test "should destroy dish_category" do
    assert_difference('DishCategory.count', -1) do
      delete dish_category_url(@dish_category), as: :json
    end

    assert_response 204
  end
end
