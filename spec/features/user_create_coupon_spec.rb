require 'rails_helper'

feature 'User create coupon' do
  scenario 'successfully' do
    promotion = create(:promotion, status: :approved)

    visit promotion_path(promotion)
    click_on 'Emitir cupons'

    cupons = Coupon.count
    expect(cupons).to eq(promotion.max_usage)
    expect(page).to have_content("Foram criados #{promotion.max_usage} cupons")
  end

  scenario 'Promotion needs to be approved to show button' do
    promotion = create(:promotion, status: :waiting_approval)

    visit promotion_path(promotion)

    expect(page).to_not have_link("Emitir cupons")

    expect(page).to have_content("Promoção aguardando aprovação")
  end

  scenario 'Promotion needs to be approved to send coupons through URL' do
    promotion = create(:promotion, status: :waiting_approval)

    page.driver.submit :post, promotion_coupons_path(promotion), {:promotion_id => promotion}

    expect(current_path).to eq(promotion_path(promotion))

    expect(page).to have_content("Promoção aguardando aprovação")
  end




end
