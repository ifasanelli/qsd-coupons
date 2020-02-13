require 'rails_helper'
feature 'User view approved promotions ' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:promotion, description: 'Natal da Loca',
                       status: :waiting_for_approval)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'
    click_on 'Natal da Loca'
    click_on 'Aprovar'
    click_on 'Promoções'
    click_on 'Promoções aprovadas'

    expect(page).to have_content('Email')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('Data/hora')
    expect(page).to have_content('Promoção')
  end
  scenario 'there are no promotions approved' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:promotion, description: 'Natal da Loca',
                       status: :waiting_for_approval)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'
    click_on 'Promoções aprovadas'

    expect(page).to have_content('Nenhuma promoção aprovada')
  end
end
