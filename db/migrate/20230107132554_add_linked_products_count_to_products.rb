class AddLinkedProductsCountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :linked_products_count, :integer
    add_check_constraint :products, 'linked_products_count >= 0', name: 'linked_products_count_check'
  end
end
