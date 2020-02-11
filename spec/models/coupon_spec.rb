require 'rails_helper'

describe Coupon do
  describe '#register_coupon_usage' do
    it 'sucessfully' do
      coupon = create(:coupon, code: 'NATAL0001')

      result = coupon.register_coupon_usage(order_number: '0E027A')

      expect(result.valid?).to be_truthy
    end

    it 'and order_number must be present' do
      coupon = create(:coupon, code: 'NATAL0001')

      result = coupon.register_coupon_usage(order_number: nil)

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include 'Número do pedido não '\
                                                     'pode ficar em branco'
    end
  end
end
