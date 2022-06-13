class ChangeTaskStatusColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :tasks, :status
    execute <<-SQL
      CREATE TYPE task_status AS ENUM ('pending', 'processing', 'complete', 'error');
    SQL
    add_column :tasks, :status, :task_status
  end

  def down
    remove_column :tasks, :status
    add_column :tasks, :status, :string
    execute <<-SQL
      DROP TYPE task_status;
    SQL
  end
end
