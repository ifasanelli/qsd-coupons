FactoryBot.define do
  factory :promotion do
    description { 'Natal da Loca' }
    prefix { 'NATAL' }
    discount_percentage { 10.0 }
    max_discount_value { 50 }
    start_date { Date.current }
    end_date { 1.day.from_now }
    max_usage { 10 }
    user
  end
end
