# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_20_143543) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "author_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "loan_date_start", null: false
    t.datetime "loan_date_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.date "reservation_date_start", null: false
    t.date "reservation_date_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reservations_on_book_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "authors", on_delete: :cascade
  add_foreign_key "books", "categories", on_delete: :cascade
  add_foreign_key "loans", "books", on_delete: :cascade
  add_foreign_key "loans", "users", on_delete: :cascade
  add_foreign_key "reservations", "books", on_delete: :cascade
  add_foreign_key "reservations", "users", on_delete: :cascade
end
