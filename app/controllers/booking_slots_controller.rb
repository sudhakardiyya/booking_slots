class BookingSlotsController < ApplicationController
  include ApplicationHelper
  require 'time'

  def index
    date = params[:date]
    @booked_slots = []
    @available_from_slot = 9 # Skip slots (range from 1 - 8)

    @slots = SlotTiming.all
    if date.present?
      begin
        date = format_date(date, "%m/%d/%Y")
        # Bookked Slots
        @booked_slots = BookingSlot.where(date: date).pluck(:slot_timing_id)

        # Next date all slots available
        if Date.today < date
          @available_from_slot = 1
          return
        end

        # Slots Avaiablity
        current_slot = (Time.now+1.hour).strftime("%H:%M")
        if current_slot.split(":")[0].to_i < 10 # Before slot timings
          if current_slot.split(":")[1].to_i == 0
            @available_from_slot = 2
          else
            @available_from_slot = 1
          end
        else # Between slots timings
          available_slot = SlotTiming.where("(start_at between '#{current_slot}:00' and '18:00:00') and (((start_at - '#{current_slot}:00')*24) >= 1)").first
          @available_from_slot = available_slot.id if available_slot
        end

      rescue Exception => e
      end
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @book_slot = BookingSlot.new(slot_timing_id: params[:slot], date: format_date(params[:date], "%m/%d/%Y"))
    @slot_name = SlotTiming.where(id: params[:slot]).first
  end

  def create
    slot = slot_params[:slot_timing_id]
    @date = slot_params[:date]
    @errors = []

    if slot.blank? || [1..8].include?(slot.to_i)
      @errors << "Please enter a valid slot"
      return
    end
    if @date.present?
      begin
        date = format_date(@date, "%m/%d/%Y")
        # Skip previous date
        if Date.today > date
          @errors << "Please enter a valid date."
          return
        end
        BookingSlot.find_or_create_by(slot_timing_id: slot, date: date, book_name: slot_params[:book_name], book_number: slot_params[:book_number])
      rescue Exception => e
        @errors << "Please enter a valid date."
      end
    end

    respond_to do |format|
      format.js
      format.html
    end

  end

  private

def slot_params
   params.require(:booking_slot).permit(:book_name, :book_number, :date, :slot_timing_id, :slot)
end
end
