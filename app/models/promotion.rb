class Promotion < ApplicationRecord
  validates :description, :prefix, :discount_percentage, :max_discount_value,
            :start_date, :end_date, :max_usage, presence: true
  validates :prefix, length: { maximum: 6 }
  validates :discount_percentage,
            numericality: { greater_than: 0,
                            less_than_or_equal_to: 100 }

  validate :is_start_date_in_present?
  validate :is_start_date_greater_than_end_date?

  def is_start_date_in_present?
    if start_date.present? && start_date < Date.current
      errors.add :start_date, 'não pode estar no passado'
    end
  end

  def is_start_date_greater_than_end_date?
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add :start_date, 'não pode ser maior que a Data de fim'
    end
  end
end
