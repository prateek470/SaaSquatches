class AddDayCombinationsRefToTimeSlots < ActiveRecord::Migration
  def change
    add_reference :time_slots, :day_combination, index: true
  end
end
