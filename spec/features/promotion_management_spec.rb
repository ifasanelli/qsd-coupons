require 'rails_helper'

feature 'Promotion management' do
  context 'user sees all promotions' do
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

  context 'user registers a promotion' do
    scenario 'successfully' do
      visit root_path
      click_on 'Promoções'
      click_on 'Registrar promoção'

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

      expect(page).to have_content('Promoção registrada com sucesso')
      expect(page).to have_content('Páscoa da Locaweb com você')
      expect(page).to have_content('PASCOA')
      expect(page).to have_content('10.0%')
      expect(page).to have_content(20)
      expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
      expect(page).to have_content(1.day.from_now.strftime('%d/%m/%Y'))
      expect(page).to have_content(10)
    end

    scenario 'and returns to the promotions index' do
      visit new_promotion_path

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

      click_on 'Voltar'

      expect(page).to have_content 'Páscoa da Locaweb com você'
      expect(current_path).to eq promotions_path
    end
  end

  context 'user edits a promotion' do
    scenario 'successfully' do
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
  end
end
