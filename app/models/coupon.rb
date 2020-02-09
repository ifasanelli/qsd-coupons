class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: %i[ available unavailable ]
end
