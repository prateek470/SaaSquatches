class AddTimeSlotsRefToClassroomTimings < ActiveRecord::Migration
  def change
    add_reference :classroom_timings, :time_slot, index: true
  end
end
