class AddSemestersRefToClassroomTimings < ActiveRecord::Migration
  def change
    add_reference :classroom_timings, :semester, index: true
  end
end
