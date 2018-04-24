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

ActiveRecord::Schema.define(version: 2018_04_24_175237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_invoices", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.boolean "collected", default: false
    t.datetime "deadline"
    t.string "serial_number", default: ""
    t.string "description", default: ""
    t.bigint "vendor_id"
    t.index ["vendor_id"], name: "index_active_invoices_on_vendor_id"
  end

  create_table "active_invoices_loads", id: false, force: :cascade do |t|
    t.bigint "load_id", null: false
    t.bigint "active_invoice_id", null: false
  end

  create_table "active_invoices_revenues", id: false, force: :cascade do |t|
    t.bigint "active_invoice_id", null: false
    t.bigint "revenue_id", null: false
  end

  create_table "credit_notes", force: :cascade do |t|
    t.bigint "vendor_id"
    t.date "date"
    t.decimal "total"
    t.index ["vendor_id"], name: "index_credit_notes_on_vendor_id"
  end

  create_table "credit_notes_revenues", id: false, force: :cascade do |t|
    t.bigint "credit_note_id", null: false
    t.bigint "revenue_id", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "contract_start_date"
    t.date "contract_end_date"
    t.string "role"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "financial_contributions", force: :cascade do |t|
    t.string "desc"
    t.date "date"
    t.decimal "total"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_financial_contributions_on_user_id"
  end

  create_table "financial_contributions_payments", id: false, force: :cascade do |t|
    t.bigint "financial_contribution_id", null: false
    t.bigint "payment_id", null: false
  end

  create_table "fuel_receipts", force: :cascade do |t|
    t.decimal "total"
    t.datetime "date_of_issue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "vehicle_id"
    t.bigint "vendor_id"
    t.index ["vehicle_id"], name: "index_fuel_receipts_on_vehicle_id"
    t.index ["vendor_id"], name: "index_fuel_receipts_on_vendor_id"
  end

  create_table "fuel_receipts_invoices", id: false, force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "fuel_receipt_id", null: false
  end

  create_table "insurance_receipts", force: :cascade do |t|
    t.decimal "paid"
    t.string "method_of_payment"
    t.string "policy_number"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "insurance_id"
    t.index ["insurance_id"], name: "index_insurance_receipts_on_insurance_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.decimal "total"
    t.string "serial_of_contract"
    t.string "description"
    t.integer "recurrence"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.bigint "vendor_id"
    t.index ["user_id"], name: "index_insurances_on_user_id"
    t.index ["vendor_id"], name: "index_insurances_on_vendor_id"
  end

  create_table "insurances_vehicles", id: false, force: :cascade do |t|
    t.bigint "insurance_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["insurance_id", "vehicle_id"], name: "index_insurances_vehicles_on_insurance_id_and_vehicle_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.boolean "paid", default: false
    t.string "serial_number"
    t.bigint "vendor_id"
    t.bigint "user_id"
    t.boolean "general_expense", default: false
    t.index ["user_id"], name: "index_invoices_on_user_id"
    t.index ["vendor_id"], name: "index_invoices_on_vendor_id"
  end

  create_table "invoices_payments", id: false, force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "payment_id", null: false
    t.index ["invoice_id", "payment_id"], name: "index_invoices_payments_on_invoice_id_and_payment_id"
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

  create_table "loads", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "vendor_id"
    t.string "from"
    t.string "to"
    t.string "serial_number"
    t.integer "weight"
    t.date "date"
    t.string "desc"
    t.decimal "price"
    t.index ["vehicle_id"], name: "index_loads_on_vehicle_id"
    t.index ["vendor_id"], name: "index_loads_on_vendor_id"
  end

  create_table "maintenances", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.date "date"
    t.date "deadline"
    t.string "desc"
    t.integer "km"
    t.index ["vehicle_id"], name: "index_maintenances_on_vehicle_id"
  end

  create_table "other_expenses", force: :cascade do |t|
    t.string "desc"
    t.decimal "total"
    t.date "date"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_other_expenses_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "paid"
    t.string "method_of_payment"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments_salaries", id: false, force: :cascade do |t|
    t.bigint "salary_id", null: false
    t.bigint "payment_id", null: false
  end

  create_table "payments_sanctions", id: false, force: :cascade do |t|
    t.bigint "sanction_id", null: false
    t.bigint "payment_id", null: false
  end

  create_table "payments_vehicle_taxes", id: false, force: :cascade do |t|
    t.bigint "vehicle_tax_id", null: false
    t.bigint "payment_id", null: false
  end

  create_table "revenues", force: :cascade do |t|
    t.decimal "total"
    t.date "date"
    t.string "method_of_payment"
  end

  create_table "salaries", force: :cascade do |t|
    t.bigint "employee_id"
    t.decimal "total"
    t.date "month"
    t.date "deadline"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "sanctions", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "total"
    t.date "date"
    t.date "deadline"
    t.string "description"
    t.index ["user_id"], name: "index_sanctions_on_user_id"
  end

  create_table "sanctions_vehicles", id: false, force: :cascade do |t|
    t.bigint "sanction_id", null: false
    t.bigint "vehicle_id", null: false
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

  create_table "users", force: :cascade do |t|
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

  create_table "vehicle_taxes", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.date "date"
    t.date "deadline"
    t.decimal "total"
    t.index ["vehicle_id"], name: "index_vehicle_taxes_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "type_of_vehicle"
    t.boolean "charge_general_expenses", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "adress"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "active_invoices", "vendors"
  add_foreign_key "credit_notes", "vendors"
  add_foreign_key "employees", "users"
  add_foreign_key "financial_contributions", "users"
  add_foreign_key "fuel_receipts", "vehicles"
  add_foreign_key "fuel_receipts", "vendors"
  add_foreign_key "insurance_receipts", "insurances"
  add_foreign_key "insurances", "users"
  add_foreign_key "insurances", "vendors"
  add_foreign_key "invoices", "users"
  add_foreign_key "invoices", "vendors"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "loads", "vehicles"
  add_foreign_key "loads", "vendors"
  add_foreign_key "maintenances", "vehicles"
  add_foreign_key "other_expenses", "users"
  add_foreign_key "salaries", "employees"
  add_foreign_key "sanctions", "users"
  add_foreign_key "sold_line_items", "active_invoices"
  add_foreign_key "vehicle_taxes", "vehicles"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vendors", "users"
end
