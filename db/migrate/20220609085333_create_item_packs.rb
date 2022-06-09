class CreateItemPacks < ActiveRecord::Migration[7.0]
  def change
    create_table :item_packs do |t|
      t.string :name
      t.boolean :canonical, default: false

      t.timestamps
    end
  end
end
