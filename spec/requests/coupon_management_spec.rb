require 'rails_helper'

describe 'Coupon management' do
  context '#burn' do
    it 'successfully' do
      promotion = create(:promotion)
      create(:coupon,
             code: 'NATAL0001', status: :created, promotion: promotion)

      post '/api/v1/coupon/NATAL0001/burn'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status :ok
      expect(json[:code]).to eq 'NATAL0001'
      expect(json[:status]).to eq 'burned'
    end

    it 'and coupon with this code does not exists' do
      post '/api/v1/coupon/NATAL0002/burn'

      expect(response).to have_http_status :not_found
    end

    it 'try to burn a coupon twice' do
      promotion = create(:promotion)
      create(:coupon,
             code: 'NATAL0001', status: :burned, promotion: promotion)

      post '/api/v1/coupon/NATAL0001/burn'

      expect(response).to have_http_status :forbidden
    end
  end
end
