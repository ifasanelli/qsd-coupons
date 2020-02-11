require 'rails_helper'

feature 'User activate promotion' do
  scenario 'successfully' do
    user = create(:user, email: 'outro@gmail.com')
    create(:promotion, description: 'Dia del muertos',
                       status: :waiting_for_approval)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'
    click_on 'Dia del muertos'
    click_on 'Aprovar'
    expect(page).to have_content('Promoção aprovada com sucesso')
  end

  scenario 'and must be a different user to view button' do
    user = create(:user, email: 'outro@gmail.com')
    create(:promotion, description: 'Dia del muertos',
                       status: :waiting_for_approval, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Promoções'
    click_on 'Dia del muertos'

    expect(page).not_to have_button('Aprovar')
  end
end
