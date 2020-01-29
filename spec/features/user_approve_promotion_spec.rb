require 'rails_helper'

feature 'User approve promotion' do
  xscenario 'successfully' do
    # Arrange
    promotion = create(:promotion)
    puts promotion

    # ACT
    visit root_path
    click_on 'Promoções'
    click_on promotion.prefix
    click_on 'Aprovar'

    # Assert
    expect(page).to have_content(promotion.prefix)
    expect(page).to have_content('Promoção aprovada')
    expect(page).to have_content("Foram criados #{promotion.max_usage} cupons: ")
    expect(page).to have_content("#{promotion.prefix}0001 ")
    expect(page).to have_content("#{promotion.prefix}0002 ")
    expect(page).to have_content("#{promotion.prefix}0003 ")


  end
end
