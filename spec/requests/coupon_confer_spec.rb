require 'rails_helper'

describe 'Coupon confer' do
  context 'Must be rendered a JSON with the information for a given coupon' do
    it 'successfully' do
      promotion = create(:promotion, status: :approved,
                                     discount_percentage: 30.0, product_id: 2)
      coupon = create(:coupon, code: 'HOSP0001', promotion: promotion,
                               status: :available)

      get confer_api_v1_coupons_path, params: { coupon: coupon.code, price: 100,
                                                product: 2 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:discount]).to eq('30.0')
    end

    it 'non-existent coupon' do
      get confer_api_v1_coupons_path, params: { coupon: 'HOSP9999', price: 100,
                                                product: 2 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:not_found)
      expect(converted_json[:error]).to eq('Cupom inexistente')
    end

    it 'a invalid coupon' do
      promotion = create(:promotion, status: :approved,
                                     discount_percentage: 30.0, product_id: 2)
      coupon = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: coupon.code, price: 100,
                                                product: 3 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(422)
      expect(converted_json[:error]).to eq('Cupom inválido para o produto '\
                                            'especificado')
    end

    it 'a discout bigger than max usage' do
      promotion = create(:promotion, status: :approved,
                                     discount_percentage: 50.0, product_id: 2,
                                     max_discount_value: 5)
      coupon = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)

      get confer_api_v1_coupons_path, params: { coupon: coupon.code, price: 100,
                                                product: 2 }

      converted_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(converted_json[:discount]).to eq('5.0')
    end
  end
end
