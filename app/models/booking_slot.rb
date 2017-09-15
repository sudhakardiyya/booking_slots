class BookingSlot < ApplicationRecord
  belongs_to :slot_timing
  default_scope -> {where(deleted: false)}
end
