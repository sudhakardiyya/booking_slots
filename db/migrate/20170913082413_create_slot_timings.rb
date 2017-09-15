class CreateSlotTimings < ActiveRecord::Migration[5.1]
  def change
    create_table :slot_timings do |t|
      t.string :slot
      t.time :start_at
      t.time :end_at
      t.boolean :deleted, default: false # prevents the record deletion from the table
      t.timestamps null: false
    end

    slots = ["10:00-11:00", "11:00-12:00", "12:00-13:00", "13:00-14:00", "15:00-16:00", "16:00-17:00", "17:00-18:00", "18:00-19:00"]

    slots.each do |slot|
      SlotTiming.find_or_create_by(slot: slot, start_at: slot.split("-")[0], end_at: slot.split("-")[1])
    end

    add_index :slot_timings, :deleted
    add_index :slot_timings, [:end_at, :start_at, :deleted], name: "slot_timings_sdd"
    add_index :slot_timings, [:slot, :deleted]
  end
end
