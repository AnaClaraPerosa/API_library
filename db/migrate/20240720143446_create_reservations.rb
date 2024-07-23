class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :book, null: false, foreign_key: { on_delete: :cascade }
      t.date :reservation_date_start, null: false
      t.date :reservation_date_end, null: false

      t.timestamps
    end
  end
end
