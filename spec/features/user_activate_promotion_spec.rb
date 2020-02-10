require 'rails_helper'

feature 'User activate a promotion' do
  scenario 'successfully' do
    create(:promotion, description: 'Natal da Loca',
                       status: :waiting_for_approval)

    visit root_path
    click_on 'Promoções'
    click_on 'Natal da Loca'
    click_on 'Aprovar'
    expect(page).to have_content('Promoção aprovada com sucesso')
  end
end
