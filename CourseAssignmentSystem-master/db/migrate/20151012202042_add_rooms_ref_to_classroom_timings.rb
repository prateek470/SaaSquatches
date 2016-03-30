class AddRoomsRefToClassroomTimings < ActiveRecord::Migration
  def change
    add_reference :classroom_timings, :room, index: true
  end
end
