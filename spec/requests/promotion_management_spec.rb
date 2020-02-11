require 'rails_helper'

describe 'Coupon management' do
  context '#approve' do
    scenario 'must be blocked via post' do
      user = create(:user, email: 'teste@gmail.com')
      promotion = create(:promotion, user: user)

      login_as(user, scope: :user)
      post approve_promotion_path(promotion.id)

      expect(response.status).to eq 302
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include('Você não pode fazer essa ação')
    end
  end
end
