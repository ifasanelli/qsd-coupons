class AddProductTypeToPromotion < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :product_type, :string
  end
end