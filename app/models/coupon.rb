class Coupon < ApplicationRecord
  enum status: { created: 0, burned: 5}
  belongs_to :promotion
end
