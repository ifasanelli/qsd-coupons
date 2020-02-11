require 'rails_helper'

feature 'User edits a promotion' do
  scenario 'successfully' do
    products = [Product.new(1, 'HOSP'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    create(:promotion, description: 'Natal da Loca')

    visit root_path
    click_on 'Promoções'
    click_on 'Natal da Loca'
    click_on 'Editar'

    within 'form' do
      fill_in 'Descrição', with: 'Páscoa da Locaweb com você'
      fill_in 'Prefixo', with: 'PASCOA'
      fill_in 'Porcentagem de desconto', with: 10
      fill_in 'Valor máximo de desconto', with: 20
      fill_in 'Data de início', with: Date.current
      fill_in 'Data de fim', with: 1.day.from_now
      fill_in 'Uso máximo', with: 10

      click_on 'Enviar'
    end

    expect(page).to have_content('Promoção editada com sucesso')
    expect(page).to have_content('Páscoa da Locaweb com você')
    expect(page).to have_content('PASCOA')
    expect(page).to have_content('10.0%')
    expect(page).to have_content(20)
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content(1.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content(10)
  end
  scenario 'with all fields in blank' do
    products = [Product.new(1, 'HOSP'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    promotion = create(:promotion)

    visit edit_promotion_path(promotion)
    within 'form' do
      fill_in 'Descrição', with: ''
      fill_in 'Prefixo', with: ''
      fill_in 'Porcentagem de desconto', with: ''
      fill_in 'Valor máximo de desconto', with: ''
      fill_in 'Data de início', with: ''
      fill_in 'Data de fim', with: ''
      fill_in 'Uso máximo', with: ''
      click_on 'Enviar'
    end

    expect(page).to have_content('Há erros de preenchimento:')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Porcentagem de desconto não pode ficar '\
                                 'em branco')
    expect(page).to have_content('Valor máximo de desconto não pode ficar '\
                                 'em branco')
    expect(page).to have_content('Uso máximo não pode ficar em branco')
  end
end
