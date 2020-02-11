class Coupon < ApplicationRecord
  enum status: { created: 0, burned: 5 }
  belongs_to :promotion
  has_one :burnt_coupon, dependent: :destroy
  def register_coupon_usage(order_number:)
    @order_number = order_number
    BurntCoupon.create(order_number: @order_number,
                       date: Time.current.time, coupon_id: id, code: code)
    burned!
  end
end
