class AddApprovedByToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :approved_by
  end
end
