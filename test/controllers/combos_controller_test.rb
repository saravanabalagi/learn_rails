require 'test_helper'

class CombosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @combo = combos(:one)
  end

  test "should get index" do
    get combos_url, as: :json
    assert_response :success
  end

  test "should create combo" do
    assert_difference('Combo.count') do
      post combos_url, params: { combo: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show combo" do
    get combo_url(@combo), as: :json
    assert_response :success
  end

  test "should update combo" do
    patch combo_url(@combo), params: { combo: {  } }, as: :json
    assert_response 200
  end

  test "should destroy combo" do
    assert_difference('Combo.count', -1) do
      delete combo_url(@combo), as: :json
    end

    assert_response 204
  end
end
