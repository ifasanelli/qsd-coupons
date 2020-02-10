class AddRefProductToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :product_id, :integer
  end
end
