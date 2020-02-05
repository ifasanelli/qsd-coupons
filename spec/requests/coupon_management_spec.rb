require 'rails_helper'

describe 'Coupon management' do
  context '#use' do
    it 'successfully' do
      promotion = create(:promotion)
      coupon = create(:coupon, 
                      code: 'NATAL0001', status: :created, promotion: promotion)

      patch "/api/v1/promotions/1/coupons/#{coupon.id}/use"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status :ok
      expect(json[:code]).to eq 'NATAL0001'
      expect(json[:status]).to eq 'burned'

    end
  end
end