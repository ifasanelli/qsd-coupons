class BurntCoupon < ApplicationRecord
  belongs_to :coupon

  validates :order_number, presence: true
end
