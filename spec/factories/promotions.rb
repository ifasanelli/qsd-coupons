FactoryBot.define do
  factory :promotion do
    description { 'MyString' }
    prefix { 'MyString' }
    discount_percentage { '9.99' }
    max_discount_value { '9.99' }
    start_date { '2020-01-28' }
    end_date { '2020-01-28' }
    max_usage { 1 }
    status { 1 }
  end
end
