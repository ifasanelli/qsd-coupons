require 'rails_helper'

context 'Promotion management' do
  scenario 'user sees all promotions' do
    create(:promotion)
    create(?)

    visit root_path
    click_on 'Promocões'

  end
end