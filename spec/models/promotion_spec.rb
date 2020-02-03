require 'rails_helper'

describe Promotion do
  context 'on creating' do
    it 'successfully' do
      promotion = build(:promotion,
                        description: 'Natal da Loca', prefix: 'NATAL',
                        discount_percentage: 10.0, max_discount_value: 50,
                        start_date: Date.current, end_date: 1.day.from_now,
                        max_usage: 10)

      result = promotion.valid?

      expect(result).to be_truthy
    end
    it 'and all fields must be filled' do
      promotion = Promotion.new

      result = promotion.valid?

      expect(result).to be_falsey
    end
    it 'and prefix length should not be greater 6 characters' do
      promotion = build(:promotion, prefix: 'PREFIXOMUITOLONGO')

      is_valid = promotion.valid?
      result = promotion.errors.full_messages

      expect(is_valid).to be_falsey
      expect(result).to include('Prefixo é muito longo (máximo: 6 caracteres)')
    end
    it 'and discount percentage must be greater than 0 percent' do
      promotion = build(:promotion, discount_percentage: -1)

      is_valid = promotion.valid?
      result = promotion.errors.full_messages

      expect(is_valid).to be_falsey
      expect(result).to include('Porcentagem de desconto deve ser maior que 0')
    end
    it 'and discount percentage must be lesser or equal to 100' do
      promotion = build(:promotion, discount_percentage: 101)

      is_valid = promotion.valid?
      result = promotion.errors.full_messages

      expect(is_valid).to be_falsey
      expect(result).to include('Porcentagem de desconto deve ser menor ou '\
                                'igual a 100')
    end
    it 'and start date must be in present' do
      promotion = build(:promotion, start_date: 1.day.ago)

      is_valid = promotion.valid?
      result = promotion.errors.full_messages

      expect(is_valid).to be_falsey
      expect(result).to include('Data de início não pode estar no passado')
    end
    it 'and start date must be lesser than end date' do
      promotion = build(:promotion,
                        start_date: 1.day.from_now, end_date: Date.current)

      is_valid = promotion.valid?
      result = promotion.errors.full_messages

      expect(is_valid).to be_falsey
      expect(result).to include('Data de início não pode ser '\
                                'maior que a Data de fim')
    end
  end
  context '#start_date_in_present?' do
    it 'successfully' do
      promotion = build(:promotion, start_date: Date.current)

      promotion.start_date_in_present?
      result = promotion.errors.full_messages

      expect(result).not_to include('Data de início não pode estar no passado')
    end
    it 'and date is in the past' do
      promotion = build(:promotion, start_date: 1.day.ago)

      promotion.start_date_in_present?
      result = promotion.errors.full_messages

      expect(result).to include('Data de início não pode estar no passado')
    end
  end
  context '#start_date_greater_than_end_date?' do
    it 'successfully' do
      promotion = build(:promotion,
                        start_date: Date.current, end_date: 1.day.from_now)

      promotion.start_date_greater_than_end_date?
      result = promotion.errors.full_messages

      expect(result).not_to include('Data de início não pode ser '\
                                    'maior que a Data de fim')
    end
    it 'and end date greater than start date' do
      promotion = build(:promotion,
                        start_date: 1.day.from_now, end_date: Date.current)

      promotion.start_date_greater_than_end_date?
      result = promotion.errors.full_messages

      expect(result).to include('Data de início não pode ser '\
                                'maior que a Data de fim')
    end
  end
end
