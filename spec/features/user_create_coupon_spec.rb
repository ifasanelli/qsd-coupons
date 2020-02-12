require 'rails_helper'

feature 'User create coupon' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    promotion = create(:promotion, status: :approved, user: user, max_usage: 33)

    login_as(user, scope: :user)
    visit promotion_path(promotion)
    click_on 'Emitir cupons'

    cupons = promotion.coupons.count
    promotion.reload
    expect(cupons).to eq(promotion.max_usage)
    expect(promotion).to be_issued
    expect(page).to have_content("Foram criados #{promotion.max_usage} cupons")
  end

  scenario '(promotion needs to be approved to show button)' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    promotion = create(:promotion, status: :waiting_for_approval, user: user)

    login_as(user, scope: :user)
    visit promotion_path(promotion)

    expect(page).to_not have_link('Emitir cupons')
    expect(page).to have_content('Promoção aguardando aprovação')
  end

  scenario '(promotion must be approved to issue coupons by url)' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    promotion = create(:promotion, status: :waiting_for_approval, user: user)

    login_as(user, scope: :user)
    page.driver.submit :post, generate_coupons_promotion_path(promotion),
                       promotion_id: promotion.id

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Promoção aguardando aprovação')
  end

  scenario '(must be authenticated)' do
    promotion = create(:promotion, status: :waiting_for_approval)
    page.driver.submit :post, generate_coupons_promotion_path(promotion.id), {}
    expect(current_path).to eq(new_user_session_path)
  end

  scenario '(create a single coupon after creating the first )' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    promotion = create(:promotion, status: :approved, max_usage: 3)

    login_as(user, scope: :user)
    visit promotion_path(promotion)
    click_on 'Emitir cupons'
    click_on 'Emitir cupons'

    expect(page).to have_content('NATAL0001')
    expect(page).to have_content('NATAL0002')
    expect(page).to have_content('NATAL0003')
    expect(page).to have_content('NATAL0004')
  end
end
