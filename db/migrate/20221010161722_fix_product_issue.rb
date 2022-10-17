class FixProductIssue < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_issues, :attribute, :test_attribute
    add_reference :product_issues, :resolution_task
    add_reference :product_issues, :product_translation
  end
end
