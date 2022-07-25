class AddUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.string :provider
      t.string :uid
      t.string :picture_url

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, [:uid, :provider], unique: true
  end
end
