require 'test_helper'

class Vendor::RestaurantOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vendor_restaurant_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get vendor_restaurant_orders_show_url
    assert_response :success
  end

end
