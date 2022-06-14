class AddBacktraceToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :backtrace, :text
  end
end
