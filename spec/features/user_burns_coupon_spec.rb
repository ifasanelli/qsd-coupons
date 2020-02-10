require 'rails_helper'

feature 'User burns coupon' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    promotion = create(:promotion, status: :approved)

    login_as(user, scope: :user)
    visit promotion_path(promotion)
    click_on 'Emitir cupons'
    click_on 'NATAL0001'
    click_on 'Deletar cupom'

    expect(page).to_not have_content('NATAL0001')
    expect(current_path).to eq(promotion_path(promotion))
  end
  scenario 'and cannot burn it again' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    promotion = create(:promotion, status: :approved)
    coupon = create(:coupon, promotion_id: promotion.id)

    login_as(user, scope: :user)
    visit promotion_coupon_path(promotion, coupon)
    click_on 'Deletar cupom'
    visit promotion_coupon_path(promotion, coupon)

    expect(page).to_not have_content('NATAL0001')
    expect(current_path).to eq(promotion_path(promotion))
  end
end
