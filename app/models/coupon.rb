class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { available: 0, unavailable: 1 }
end
