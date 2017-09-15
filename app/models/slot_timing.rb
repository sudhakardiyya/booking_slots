class SlotTiming < ActiveRecord::Base
  has_many :booking_slots
  default_scope -> {where(deleted: false)}

  def self.slot_status_class(slot_id, booked_slots, available_from)
    if booked_slots.include?(slot_id)
      return 'btn-danger'
    elsif available_from <= slot_id && available_from < 9
      return 'btn-success'
    else
      return 'btn-default disabled'
    end
  end
end
