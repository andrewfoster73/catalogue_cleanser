class AddCreditNoteLinesCountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :credit_note_lines_count, :integer
    add_check_constraint :products, 'credit_note_lines_count >= 0', name: 'credit_note_lines_count_check'
  end
end
