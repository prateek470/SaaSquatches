class AddPreferenceToFaculties < ActiveRecord::Migration
  def change
    add_column :faculties, :preference, :integer
  end
end
