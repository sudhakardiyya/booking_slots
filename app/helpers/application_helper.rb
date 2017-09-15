module ApplicationHelper
	def input_date_format
    "%Y-%m-%d"
  end

  def format_date(date, format = input_date_format)
    Date.strptime(date, format)
  end

  def date_format(date)
    date.strftime('%m/%d/%Y')
  end

  def slot_details(slot, booked_slots)
    if booked_slots.include?(slot.id)
      booked_slot = BookingSlot.where(slot_timing_id: slot.id).first
      return " #{booked_slot.book_name} #{booked_slot.book_number}"
    end
  end
end
