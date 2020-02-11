class CreateBurntCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :burnt_coupons do |t|
      t.string :order_number
      t.references :coupon, null: false, foreign_key: true
      t.string :code
      t.datetime :date

      t.timestamps
    end
  end
end
