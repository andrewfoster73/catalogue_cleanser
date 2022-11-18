class DropUnusedColumnsFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :translations_count, :integer
    remove_column :products, :issues_count, :integer
  end
end
