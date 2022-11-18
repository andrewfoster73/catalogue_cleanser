class DropUnusedProductIssuesColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_issues, :resolution_message_key, :string
  end
end
