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

ActiveRecord::Schema.define(version: 20151104172242) do

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "sales", force: :cascade do |t|
    t.integer  "project_id"
    t.decimal  "gross"
    t.decimal  "net"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sales", ["project_id"], name: "index_sales_on_project_id"

  create_table "sales_goals", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.string   "length_of_time"
    t.date     "start_time"
    t.boolean  "success",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "sales_goals", ["user_id"], name: "index_sales_goals_on_user_id"

  create_table "time_entries", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "total_time"
  end

  add_index "time_entries", ["project_id"], name: "index_time_entries_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "public_profile",  default: false
    t.string   "time_zone",       default: "Eastern Time (US & Canada)"
    t.decimal  "hourly_rate",     default: 20.0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

end
