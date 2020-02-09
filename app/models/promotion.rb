class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  enum status: { waiting_for_approval: 0, approved: 1, issued: 2 }
  validates :description, :prefix, :discount_percentage, :max_discount_value,
            :start_date, :end_date, :max_usage, presence: true
  validates :prefix, length: { maximum: 6 }
  validates :discount_percentage,
            numericality: { greater_than: 0,
                            less_than_or_equal_to: 100 }

  validate :start_date_in_present?
  validate :start_date_greater_than_end_date?

  def start_date_in_present?
    return unless start_date.present? && start_date < Date.current

    errors.add :start_date, 'não pode estar no passado'
  end

  def start_date_greater_than_end_date?
    return unless start_date.present? && end_date.present? &&
                  start_date > end_date

    errors.add :start_date, 'não pode ser maior que a Data de fim'
  end

  def generate_coupons
    max_usage.times do |i|
      code = prefix +  (i + 1).to_s.rjust(4, '0')
      coupons.create!(code: code, status: 0)
    end
  end

  def generate_single
    actual = coupons.count
    code = prefix + actual.to_s.rjust(4, '0')
    coupons.create!(code: code, status: 0)
  end

  def discard_coupons
    coupons.status = 1
  end
end
