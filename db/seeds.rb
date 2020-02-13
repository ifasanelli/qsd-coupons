# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
promo_user = User.create!(email: 'promo_creator@gmail.com', password: '123456')

Promotion.create!([
  { 
    description: 'Ação de Graças da LOCA', prefix: 'ACAO',
    discount_percentage: 10.0, max_discount_value: 50,
    start_date: 1.day.from_now, end_date: 2.days.from_now, max_usage: 10,
    status: :issued, user: promo_user
  },
  { 
    description: 'Páscoa da Loca', prefix: 'PASCOA', discount_percentage: 20.0, 
    max_discount_value: 75, start_date: Date.current, end_date: 1.day.from_now,
    max_usage: 10, status: :waiting_for_approval, user: promo_user
  },
])

Coupon.create!([
  { code: 'ACAO0001', promotion_id: 1, status: 0 },
  { code: 'ACAO0002', promotion_id: 1, status: 0 }
])

User.create!([
  { email: 'joao@email.com', password: '123456' },
  { email: 'maria@email.com', password: '123456' }
])
