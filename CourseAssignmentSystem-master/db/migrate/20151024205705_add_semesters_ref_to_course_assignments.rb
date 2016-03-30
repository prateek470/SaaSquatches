class AddSemestersRefToCourseAssignments < ActiveRecord::Migration
  def change
    add_reference :course_assignments, :semester, index: true
  end
end
