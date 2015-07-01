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

ActiveRecord::Schema.define(version: 20150701122624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.boolean  "read",          default: false
    t.string   "name"
    t.integer  "world_id"
    t.integer  "user_id"
    t.integer  "other_user_id"
    t.integer  "item_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "events", ["item_id"], name: "index_events_on_item_id", using: :btree
  add_index "events", ["other_user_id"], name: "index_events_on_other_user_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree
  add_index "events", ["world_id"], name: "index_events_on_world_id", using: :btree

  create_table "item_types", force: :cascade do |t|
    t.string   "name"
    t.string   "joke"
    t.string   "picture"
    t.string   "kind"
    t.integer  "consumption"
    t.integer  "life_impact"
    t.integer  "lifetime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "world_id"
    t.integer  "user_id"
    t.integer  "item_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "items", ["item_type_id"], name: "index_items_on_item_type_id", using: :btree
  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree
  add_index "items", ["world_id"], name: "index_items_on_world_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "name"
    t.string   "crew",                   default: "Baby Rice"
    t.integer  "soja",                   default: 24
    t.integer  "life",                   default: 10
    t.integer  "x"
    t.integer  "y"
    t.integer  "world_id"
    t.string   "lowername"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["world_id"], name: "index_users_on_world_id", using: :btree

  create_table "worlds", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "background"
    t.integer  "max_x"
    t.integer  "max_y"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "usercount",   default: 0
  end

  add_foreign_key "events", "items"
  add_foreign_key "events", "users"
  add_foreign_key "events", "users", column: "other_user_id"
  add_foreign_key "events", "worlds"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "users"
  add_foreign_key "items", "worlds"
end
