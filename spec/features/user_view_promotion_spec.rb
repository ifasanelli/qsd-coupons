require 'rails_helper'

feature 'User view all promotions' do
  scenario 'with more than one registered' do
    create(:promotion, description: 'Natal da Loca')
    create(:promotion, description: 'Páscoa da Loca')

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
    visit promotions_path

    expect(page).to have_content 'Nenhuma promoção registrada'
  end
end

context 'sees one promotion' do
  scenario 'successfully' do
    create(:promotion, description: 'Natal da Loca')

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
