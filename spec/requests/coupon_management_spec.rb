require 'rails_helper'

describe 'Coupons management' do
  context '- index / list: ' do
    it 'should render a JSON with all coupons' do
      promotion = create(:promotion, status: :approved, discount_percentage: 30.0)
      cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)
      create(:coupon, code: 'HOSP0002', promotion_id: promotion.id)
      create(:coupon, code: 'HOSP0003', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: {coupon: cuponA.code, price: 1000, product: produto.id}

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:discount]).to eq('300')
    end
  end
end