class AddProductIssueToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :product_issue, polymorphic: true
  end
end
