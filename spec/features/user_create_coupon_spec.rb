require 'rails_helper'

feature 'user create coupon' do
  scenario 'successfully' do

    promotion = create(:promotion, status: 1)

    visit promotion_path(promotion)
    click_on "Emitir cupons"
    cupons = Coupon.count
    p Coupon.all

    expect(cupons).to eq(promotion.max_usage)
    p current_path
    expect(page).to have_content("Foram criados #{promotion.max_usage} cupons ")

  end
end