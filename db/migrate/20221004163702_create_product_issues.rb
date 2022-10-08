class CreateProductIssues < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE product_issue_status AS ENUM ('pending', 'confirmed', 'ignored', 'fixed');
    SQL
    create_table :product_issues do |t|
      t.references :product
      t.string :type
      t.string :attribute
      t.string :resolution_task_type
      t.string :resolution_suggested_replacement
      t.string :resolution_message_key
      t.timestamps
    end

    add_column :product_issues, :status, :product_issue_status
  end

  def down
    drop_table :product_issues
    execute <<-SQL
      DROP TYPE product_issue_status;
    SQL
  end
end
