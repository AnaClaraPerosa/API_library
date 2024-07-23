class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :book, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :loan_date_start, null: false
      t.datetime :loan_date_end, null: false

      t.timestamps
    end
  end
end
