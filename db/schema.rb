# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_11_121305) do

  create_table "burnt_coupons", force: :cascade do |t|
    t.string "order_number"
    t.integer "coupon_id", null: false
    t.string "code"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_burnt_coupons_on_coupon_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.integer "promotion_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_id"], name: "index_coupons_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "description"
    t.string "prefix"
    t.decimal "discount_percentage"
    t.decimal "max_discount_value"
    t.date "start_date"
    t.date "end_date"
    t.integer "max_usage"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.string "product_key"
    t.integer "user_id"
    t.index ["user_id"], name: "index_promotions_on_user_id"
  end

  create_table "record_approvals", force: :cascade do |t|
    t.string "email"
    t.datetime "date"
    t.integer "promotion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promotion_id"], name: "index_record_approvals_on_promotion_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "burnt_coupons", "coupons"
  add_foreign_key "coupons", "promotions"
  add_foreign_key "promotions", "users"
  add_foreign_key "record_approvals", "promotions"
end
