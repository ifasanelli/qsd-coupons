require 'rails_helper'

feature 'User view all promotions' do
  scenario 'with more than one registered' do
    user = create(:user, email: 'teste@gmail.com')
    create(:promotion, description: 'Natal da Loca', user: user)
    create(:promotion, description: 'Páscoa da Loca', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq promotions_path
    expect(page).to have_content 'Natal da Loca'
    expect(page).to have_content 'Páscoa da Loca'
    expect(page).to have_content 'NATAL'
    expect(page).to have_content '10.0'
    expect(page).to have_content '10.0%'
  end
  scenario 'with non-existing promotions' do
    user = create(:user, email: 'teste@gmail.com')

    login_as(user, scope: :user)
    visit promotions_path

    expect(page).to have_content 'Nenhuma promoção registrada'
  end
end

context 'sees one promotion' do
  scenario 'successfully' do
    user = create(:user, email: 'teste@gmail.com')
    create(:promotion, description: 'Natal da Loca')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'
    click_on 'Natal da Loca'

    expect(page).to have_content('Natal da Loca')
    expect(page).to have_content('NATAL')
    expect(page).to have_content('10.0%')
    expect(page).to have_content(50)
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content(1.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content(10)
  end
end
