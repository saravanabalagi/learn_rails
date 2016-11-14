class AddCouponCategoryToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_reference :coupons, :coupon_category, foreign_key: true
  end
end
