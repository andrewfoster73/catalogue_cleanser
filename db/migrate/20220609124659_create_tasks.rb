class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :type
      t.integer :context_id
      t.string :context_type
      t.text :description
      t.jsonb :before
      t.jsonb :after
      t.string :status
      t.string :error
      t.boolean :requires_approval, default: false
      t.boolean :approved, default: false
      t.timestamp :approved_at

      t.timestamps
    end
  end
end
