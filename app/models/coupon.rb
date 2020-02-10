class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { available: 0, burnt: 5, discarded: 10 }

  def confer?(product_id)
    unless available?
      return errors.add(:status, 'Cupom indisponível') && false
    end
    unless promotion.product_id == product_id.to_i
      return errors.add(:base, 'Cupom inválido para o produto especificado') && false
    end

    true
  end

  def calculate_discount(sale_price)
    discount = (promotion.discount_percentage * sale_price) / 100
    return discount if discount <= promotion.max_discount_value

    promotion.max_discount_value
  end
end
