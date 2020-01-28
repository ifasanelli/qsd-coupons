class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :description
      t.string :prefix
      t.decimal :discount_percentage
      t.decimal :max_discount_value
      t.date :start_date
      t.date :end_date
      t.integer :max_usage
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
