require 'test_helper'

class PaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get payment_methods_show_url
    assert_response :success
  end

end
