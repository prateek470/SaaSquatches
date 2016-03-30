class AddTimeSlotsRefToPreferences < ActiveRecord::Migration
  def change
    add_reference :preferences, :time_slot, index: true
  end
end
