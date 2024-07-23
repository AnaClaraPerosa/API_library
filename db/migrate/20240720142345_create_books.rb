class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :author, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
