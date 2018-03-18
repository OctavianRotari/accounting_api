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

ActiveRecord::Schema.define(version: 2018_03_16_205103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_invoices", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.boolean "collected", default: false
    t.datetime "deadline"
    t.string "serial_number", default: ""
    t.string "description", default: ""
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "adress"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_companies_on_category_id"
  end

  create_table "companies_insurances", id: false, force: :cascade do |t|
    t.bigint "insurance_id", null: false
    t.bigint "company_id", null: false
    t.index ["insurance_id", "company_id"], name: "index_companies_insurances_on_insurance_id_and_company_id"
  end

  create_table "companies_invoices", id: false, force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "company_id", null: false
    t.index ["invoice_id", "company_id"], name: "index_companies_invoices_on_invoice_id_and_company_id"
  end

  create_table "fuel_receipts", id: :serial, force: :cascade do |t|
    t.decimal "total"
    t.datetime "date_of_issue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.integer "vehicle_id"
    t.integer "litres"
    t.index ["company_id"], name: "index_fuel_receipts_on_company_id"
    t.index ["vehicle_id"], name: "index_fuel_receipts_on_vehicle_id"
  end

  create_table "insurance_receipts", id: :serial, force: :cascade do |t|
    t.decimal "paid"
    t.string "method_of_payment"
    t.string "policy_number"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "insurance_id"
    t.index ["insurance_id"], name: "index_insurance_receipts_on_insurance_id"
  end

  create_table "insurances", id: :serial, force: :cascade do |t|
    t.datetime "date_of_issue"
    t.decimal "total"
    t.string "serial_of_contract"
    t.string "description"
    t.integer "recurrence"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_insurances_on_user_id"
  end

  create_table "insurances_vehicles", id: false, force: :cascade do |t|
    t.bigint "insurance_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["insurance_id", "vehicle_id"], name: "index_insurances_vehicles_on_insurance_id_and_vehicle_id"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "user_id"
    t.boolean "paid", default: false
    t.string "serial_number"
    t.boolean "general_expense", default: false
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "invoices_vehicles", id: false, force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "vehicle_id", null: false
    t.decimal "total"
    t.index ["invoice_id", "vehicle_id"], name: "index_invoices_vehicles_on_invoice_id_and_vehicle_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "vat"
    t.decimal "amount"
    t.string "description"
    t.integer "quantity", default: 1
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.string "method_of_payment"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id"
    t.decimal "paid"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "sold_line_items", force: :cascade do |t|
    t.integer "vat"
    t.decimal "amount"
    t.string "description"
    t.integer "quantity", default: 1
    t.bigint "active_invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_invoice_id"], name: "index_sold_line_items_on_active_invoice_id"
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.decimal "total"
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.boolean "paid"
    t.string "description"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "tickets_vehicles", id: false, force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["ticket_id", "vehicle_id"], name: "index_tickets_vehicles_on_ticket_id_and_vehicle_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.json "tokens"
    t.boolean "allow_password_change", default: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", id: :serial, force: :cascade do |t|
    t.string "plate"
    t.string "type_of_vehicle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "charge_general_expenses", default: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "categories", "users"
  add_foreign_key "companies", "categories"
  add_foreign_key "fuel_receipts", "companies"
  add_foreign_key "fuel_receipts", "vehicles"
  add_foreign_key "insurance_receipts", "insurances"
  add_foreign_key "insurances", "users"
  add_foreign_key "invoices", "users"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "payments", "invoices"
  add_foreign_key "sold_line_items", "active_invoices"
  add_foreign_key "tickets", "users"
  add_foreign_key "vehicles", "users"
end
