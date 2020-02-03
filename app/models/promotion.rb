class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  enum status: { waiting_approval: 0, approved: 1, issued: 5}

  def generate_coupons
    max_usage.times do |i|
      code = prefix +  (i + 1).to_s.rjust(4, '0')
      coupons.create!(code: code)
    end
  end

  def discard_coupons
    coupons.status = 1
  end
end
