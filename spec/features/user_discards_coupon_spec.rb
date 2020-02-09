require 'rails_helper'

feature 'User discards coupon' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    promotion = create(:promotion, status: :approved)

    login_as(user, scope: :user)
    visit promotion_path(promotion)
    click_on 'Emitir cupons'
    click_on 'NATAL0001'
    click_on 'Deletar cupom'

    expect(page).to_not have_content('NATAL0001')
    expect(page).to have_content('Cupom deletado com sucesso')
  end
end
