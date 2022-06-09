class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.string :type
      t.integer :context_id
      t.string :context_type
      t.text :description
      t.jsonb :before
      t.jsonb :after
      t.string :status
      t.string :error
      t.boolean :requires_approval
      t.boolean :approved
      t.references :approved_by, foreign_key: true
      t.timestamp :approved_at

      t.timestamps
    end
  end
end
