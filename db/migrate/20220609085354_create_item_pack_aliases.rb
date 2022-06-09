class CreateItemPackAliases < ActiveRecord::Migration[7.0]
  def change
    create_table :item_pack_aliases do |t|
      t.references :item_pack, null: false, foreign_key: true
      t.string :alias
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
