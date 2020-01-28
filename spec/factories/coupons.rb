FactoryBot.define do
  factory :coupon do
    code { 'MyString' }
    promotion { nil }
    status { 1 }
  end
end
