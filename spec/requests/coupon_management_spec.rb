require 'rails_helper'

describe 'Coupons management' do
    context '- index / list: ' do
        it 'should render a JSON with all coupons' do
          promotion = create(:promotion, status: :approved, discount_percentage: 30.0 )
          cuponA = create(:coupon, code: 'HOSP0001', promotion_id: promotion.id)
          create(:coupon, code: 'HOSP0002', promotion_id: promotion.id)
          create(:coupon, code: 'HOSP0003', promotion_id: promotion.id)
          produto = Product.new(1,'Hospedagem')

          get confer_api_v1_coupon_path(cuponA), {coupon: cuponA.code,product: produto.id,price: 1000}

          converted_json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(:ok)
          expect(converted_json[0][:code]).to eq('HOSP0001')

    end
  end
end