require 'test_helper'

class OrderStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get order_statuses_show_url
    assert_response :success
  end

end
