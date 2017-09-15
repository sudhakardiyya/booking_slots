class DashboardsController < ApplicationController
  def index
    @slots = SlotTiming.all
  end
end
