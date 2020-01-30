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

  scenario '(Promotion still pending approval)' do
    promotion = create(:promotion, status: :waiting_approval)

    visit promotion_path(promotion)

    expect(page).to_not have_link("Emitir cupons")
  end
end
