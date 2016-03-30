class AddSemestersRefToFacultyCourses < ActiveRecord::Migration
  def change
    add_reference :faculty_courses, :semester, index: true
  end
end
