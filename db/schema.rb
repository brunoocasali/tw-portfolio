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

ActiveRecord::Schema.define(version: 20161203135613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reference"
    t.string   "nick"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
  end

  add_index "contacts", ["email"], name: "index_contacts_on_email", using: :btree
  add_index "contacts", ["status"], name: "index_contacts_on_status", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.boolean  "show"
    t.text     "description"
    t.integer  "kind"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "project_id"
    t.string   "download_link"
  end

  add_index "galleries", ["project_id"], name: "index_galleries_on_project_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "filename"
    t.integer  "gallery_id"
    t.string   "subtitle"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "file_size"
    t.boolean  "cover",      default: false
    t.boolean  "show",       default: false
  end

  add_index "media", ["gallery_id"], name: "index_media_on_gallery_id", using: :btree

  create_table "newsletters", force: :cascade do |t|
    t.string   "email"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "newsletters", ["email"], name: "index_newsletters_on_email", unique: true, using: :btree
  add_index "newsletters", ["project_id"], name: "index_newsletters_on_project_id", using: :btree

  create_table "print_requests", force: :cascade do |t|
    t.integer  "medium_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.integer  "size"
    t.string   "size_other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "message"
    t.integer  "status"
  end

  add_index "print_requests", ["medium_id"], name: "index_print_requests_on_medium_id", using: :btree
  add_index "print_requests", ["status"], name: "index_print_requests_on_status", using: :btree
  add_index "print_requests", ["user_id"], name: "index_print_requests_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "status"
    t.string   "code"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "projects", ["code"], name: "index_projects_on_code", unique: true, using: :btree
  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id", using: :btree
  add_index "projects", ["status"], name: "index_projects_on_status", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "address_id"
    t.datetime "start_at"
    t.datetime "finish_at"
  end

  add_index "sessions", ["address_id"], name: "index_sessions_on_address_id", using: :btree
  add_index "sessions", ["project_id"], name: "index_sessions_on_project_id", using: :btree
  add_index "sessions", ["status"], name: "index_sessions_on_status", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "address_id"
    t.string   "name"
  end

  add_index "users", ["address_id"], name: "index_users_on_address_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree

  add_foreign_key "galleries", "projects"
  add_foreign_key "media", "galleries"
  add_foreign_key "newsletters", "projects"
  add_foreign_key "print_requests", "media"
  add_foreign_key "print_requests", "users"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "sessions", "addresses"
  add_foreign_key "sessions", "projects"
  add_foreign_key "users", "addresses"
end
