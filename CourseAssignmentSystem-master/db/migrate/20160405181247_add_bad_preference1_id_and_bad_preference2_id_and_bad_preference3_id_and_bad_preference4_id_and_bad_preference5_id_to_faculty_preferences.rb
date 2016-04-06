class AddBadPreference1IdAndBadPreference2IdAndBadPreference3IdAndBadPreference4IdAndBadPreference5IdToFacultyPreferences < ActiveRecord::Migration
  def change
    add_column :faculty_preferences, :bad_preference1_id, :integer
    add_column :faculty_preferences, :bad_preference2_id, :integer
    add_column :faculty_preferences, :bad_preference3_id, :integer
    add_column :faculty_preferences, :bad_preference4_id, :integer
    add_column :faculty_preferences, :bad_preference5_id, :integer
  end
end
