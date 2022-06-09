class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :canonical, default: false
      t.integer :count

      t.timestamps
    end
  end
end
