FactoryBot.define do
  factory :coupon do
    code { 'NATAL0001' }
    status { 0 }
    promotion
  end
end
