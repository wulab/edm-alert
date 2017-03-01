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

ActiveRecord::Schema.define(version: 20170301084620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "title"
    t.string   "description"
    t.integer  "category",    default: 0
    t.string   "source_name"
    t.string   "source_url"
    t.json     "source_data"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "start_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name"
    t.string   "tel"
    t.string   "address"
    t.string   "hospital_type"
    t.integer  "postal_code"
    t.integer  "area_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "district"
    t.string   "province"
    t.string   "postal_code"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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
    t.string   "provider"
    t.string   "uid"
    t.integer  "location_id"
    t.string   "full_name"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "notified_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["location_id"], name: "index_users_on_location_id", using: :btree
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "events", "locations"
  add_foreign_key "users", "locations"
end
