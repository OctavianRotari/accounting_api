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

ActiveRecord::Schema.define(version: 2018_03_10_194440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "adress"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "category_id"
    t.bigint "user_id"
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "fuel_receipts", force: :cascade do |t|
    t.decimal "total"
    t.datetime "date_of_issue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "company_id"
    t.bigint "vehicle_id"
    t.bigint "user_id"
    t.integer "litres"
    t.index ["company_id"], name: "index_fuel_receipts_on_company_id"
    t.index ["user_id"], name: "index_fuel_receipts_on_user_id"
    t.index ["vehicle_id"], name: "index_fuel_receipts_on_vehicle_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.decimal "total"
    t.string "at_the_expense_of"
    t.string "serial_of_contract"
    t.string "description"
    t.integer "recurrence"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.bigint "company_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_insurances_on_category_id"
    t.index ["company_id"], name: "index_insurances_on_company_id"
    t.index ["user_id"], name: "index_insurances_on_user_id"
    t.index ["vehicle_id"], name: "index_insurances_on_vehicle_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "company_id"
    t.decimal "total_vat"
    t.decimal "total"
    t.string "reason"
    t.decimal "total_taxable"
    t.bigint "vehicle_id"
    t.string "type_of_invoice"
    t.integer "category_id"
    t.string "at_the_expense_of"
    t.bigint "user_id"
    t.boolean "paid", default: false
    t.string "serial_number"
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
    t.index ["vehicle_id"], name: "index_invoices_on_vehicle_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "method_of_payment"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "invoice_id"
    t.decimal "paid"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.decimal "paid"
    t.string "method_of_payment"
    t.string "policy_number"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "insurance_id"
    t.index ["insurance_id"], name: "index_receipts_on_insurance_id"
  end

  create_table "taxable_vat_fields", force: :cascade do |t|
    t.decimal "taxable"
    t.decimal "vat_rate"
    t.bigint "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invoice_id"], name: "index_taxable_vat_fields_on_invoice_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "total"
    t.integer "type_of"
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.boolean "paid"
    t.string "description"
    t.index ["user_id"], name: "index_tickets_on_user_id"
    t.index ["vehicle_id"], name: "index_tickets_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "vehicle_fields", force: :cascade do |t|
    t.integer "vehicle_id"
    t.integer "part_of_total"
    t.bigint "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invoice_id"], name: "index_vehicle_fields_on_invoice_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "type_of_vehicle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.boolean "charge_general_expenses", default: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "categories", "users"
  add_foreign_key "companies", "categories"
  add_foreign_key "companies", "users"
  add_foreign_key "fuel_receipts", "companies"
  add_foreign_key "fuel_receipts", "users"
  add_foreign_key "fuel_receipts", "vehicles"
  add_foreign_key "insurances", "companies"
  add_foreign_key "insurances", "users"
  add_foreign_key "insurances", "vehicles"
  add_foreign_key "invoices", "companies"
  add_foreign_key "invoices", "users"
  add_foreign_key "invoices", "vehicles"
  add_foreign_key "payments", "invoices"
  add_foreign_key "receipts", "insurances"
  add_foreign_key "taxable_vat_fields", "invoices"
  add_foreign_key "tickets", "users"
  add_foreign_key "tickets", "vehicles"
  add_foreign_key "vehicle_fields", "invoices"
  add_foreign_key "vehicles", "users"
end
