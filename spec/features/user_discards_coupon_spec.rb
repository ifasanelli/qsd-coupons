require 'rails_helper'

feature 'User discards coupon' do
  scenario 'successfully' do
    promotion = create(:promotion, status: :approved)

    visit promotion_path(promotion)
    click_on 'Emitir cupons'
    click_on 'NATAL0001'

    click_on 'Deletar cupom'
  end
end