class ChangeFacultyCourses < ActiveRecord::Migration
  def change
    remove_column :faculty_courses, :course1_id
    remove_column :faculty_courses, :course2_id
    remove_column :faculty_courses, :course3_id
    add_column :faculty_courses, :course_id, :integer
  end
end
