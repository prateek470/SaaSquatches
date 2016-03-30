class AddSemestersRefToFacultyPreferences < ActiveRecord::Migration
  def change
    add_reference :faculty_preferences, :semester, index: true
  end
end
