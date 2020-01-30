class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  def generate_coupons
    max_usage.times do |i|
      code = prefix +  (i + 1).to_s.rjust(4, '0')
      coupons.create!(code: code)
    end
  end
end
