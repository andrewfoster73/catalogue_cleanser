class AddLocaleAndCountryToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :locale, :string
    add_column :users, :country_alpha2, :string
  end
end
