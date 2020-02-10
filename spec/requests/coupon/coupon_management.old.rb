require 'rails_helper'

describe 'Coupons management' do
  context '- index / list: ' do
    it 'should render a JSON with all coupons' do
      promotion = create(:promotion, status: :approved, discount_percentage: 30.0)
      cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)
      create(:coupon, code: 'HOSP0002', promotion_id: promotion.id)
      create(:coupon, code: 'HOSP0003', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: cuponA.code, price: 1000, product: produto.id }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:discount]).to eq('300')
    end
  end

  context '- confer: ' do
    it 'should render a JSON with the information for a given coupon successfully' do
      promotion = create(:promotion, status: :approved, discount_percentage: 30.0, product_id: 2)
      cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: cuponA.code, price: 100, product: 2 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:discount]).to eq('30.')
    end

    it 'must render a JSON with a non-existent coupon notification' do
      promotion = create(:promotion, status: :approved, discount_percentage: 30.0, product_id: 2)
      cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: 'HOSP0002', price: 100, product: 2 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:notice]).to eq('Cupom inexistente')
    end

    it 'must render a JSON with an invalid coupon notification' do
      promotion = create(:promotion, status: :approved, discount_percentage: 30.0, product_id: 2)
      cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: cuponA.code, price: 100, product: 3 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:notice]).to eq('Cupom inválido para o produto especificado')
    end
  end
end