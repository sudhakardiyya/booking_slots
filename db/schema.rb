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

ActiveRecord::Schema.define(version: 20170913082610) do

  create_table "booking_slots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "slot_timing_id"
    t.string "book_name"
    t.string "book_number"
    t.date "date"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "slot_timing_id", "deleted"], name: "booking_slots_dsd"
    t.index ["deleted"], name: "index_booking_slots_on_deleted"
    t.index ["slot_timing_id"], name: "index_booking_slots_on_slot_timing_id"
  end

  create_table "slot_timings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slot"
    t.time "start_at"
    t.time "end_at"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_slot_timings_on_deleted"
    t.index ["end_at", "start_at", "deleted"], name: "slot_timings_sdd"
    t.index ["slot", "deleted"], name: "index_slot_timings_on_slot_and_deleted"
  end

end
