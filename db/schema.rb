# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_15_053558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concert_details", force: :cascade do |t|
    t.bigint "concert_id"
    t.integer "grade"
    t.integer "price"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_concert_details_on_concert_id"
  end

  create_table "concerts", force: :cascade do |t|
    t.text "infomation"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "sale_id"
    t.datetime "date"
    t.integer "amount"
    t.integer "added_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_payments_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "concert_id"
    t.bigint "user_id"
    t.string "grade"
    t.integer "number_of_seats"
    t.datetime "date"
    t.integer "amount"
    t.date "payment_deadline"
    t.integer "used_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_sales_on_concert_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "concert_details", "concerts"
  add_foreign_key "payments", "sales"
  add_foreign_key "sales", "concerts"
  add_foreign_key "sales", "users"
end
