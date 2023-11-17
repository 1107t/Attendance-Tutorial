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

ActiveRecord::Schema.define(version: 20231115134843) do

  create_table "add_create_to_attendances", force: :cascade do |t|
    t.integer "attendance_nextday"
    t.string "instructor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attendance_nextday"
    t.string "instructor"
    t.string "attendance_chg_status"
    t.datetime "chg_started_at"
    t.datetime "chg_finished_at"
    t.boolean "chg_permission"
    t.time "overtime_at"
    t.string "overtime_note"
    t.string "new_instructor"
    t.datetime "workedhours"
    t.datetime "overtime_hours"
    t.string "applicants"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_name"
    t.integer "base_number"
    t.string "information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2023-08-28 23:00:00"
    t.datetime "work_time", default: "2023-08-29 00:00:00"
    t.string "affiliation"
    t.integer "employee_number"
    t.integer "uid"
    t.datetime "basic_work_time", default: "2023-08-28 10:00:00"
    t.datetime "designated_work_start_time", default: "2023-08-28 09:00:00"
    t.datetime "designated_work_end_time", default: "2023-08-28 19:00:00"
    t.boolean "superior", default: false
    t.datetime "end_time"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
