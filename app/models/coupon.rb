class Coupon < ApplicationRecord
  enum status: { available: 0, burnt: 5, discarded: 10 }
  belongs_to :promotion

  has_one :burnt_coupon, dependent: :destroy

  def confer?(product_id)
    return errors.add(:status, 'Cupom indisponível') && false unless available?

    unless promotion.product_id == product_id.to_i
      errors.add(:base, 'Cupom inválido para o produto especificado')
      return false
    end

    true
  end

  def calculate_discount(sale_price)
    discount = (promotion.discount_percentage * sale_price) / 100
    return discount if discount <= promotion.max_discount_value

    promotion.max_discount_value
  end

  def register_coupon_usage(order_number:)
    @order_number = order_number
    burnt_coupon = BurntCoupon.new(order_number: @order_number,
                                   date: Time.current.time,
                                   coupon_id: id,
                                   code: code)
    return burnt_coupon unless burnt_coupon.save

    burnt!
    burnt_coupon
  end
end
