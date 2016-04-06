class AddPreference4IdAndPreference5IdToFacultyPreferences < ActiveRecord::Migration
  def change
    add_column :faculty_preferences, :preference4_id, :integer
    add_column :faculty_preferences, :preference5_id, :integer
  end
end
