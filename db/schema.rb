# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140630060944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_roles", force: true do |t|
    t.string   "name"
    t.text     "role_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "company_name"
    t.string   "name"
    t.text     "address1"
    t.text     "address2"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.string   "salutation"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "email"
    t.string   "email_1"
    t.string   "business"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "zip"
  end

  create_table "employee_identifications", force: true do |t|
    t.integer  "type_id"
    t.string   "employee_id"
    t.string   "division"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "mid_name"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.string   "phone"
    t.string   "phone_1"
    t.integer  "ss_no"
    t.datetime "dob"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "ref_code"
    t.string   "zip"
    t.integer  "emp_id"
    t.string   "emp_type"
    t.text     "notes"
    t.string   "devision"
    t.date     "hire_date"
    t.date     "termination_date"
    t.date     "raise_date"
    t.decimal  "raise_amount"
    t.binary   "doc_or_image"
    t.string   "filename"
    t.string   "mime_type"
    t.string   "ss_no_enc"
  end

  create_table "manage_resources", force: true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "add_role_id"
  end

  create_table "payroll_informations", force: true do |t|
    t.integer  "employee_id"
    t.date     "hired_date"
    t.date     "raise_date"
    t.date     "termin_date"
    t.decimal  "raise_amount"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.text     "addres"
    t.text     "user_type"
    t.string   "last_name"
    t.boolean  "is_active",              default: true
    t.integer  "account"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
