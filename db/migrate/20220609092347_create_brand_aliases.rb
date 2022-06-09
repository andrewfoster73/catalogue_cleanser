class CreateBrandAliases < ActiveRecord::Migration[7.0]
  def change
    create_table :brand_aliases do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :alias
      t.boolean :confirmed, default: false
      t.integer :count

      t.timestamps
    end
  end
end
