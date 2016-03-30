class AddSemestersRefToPreferences < ActiveRecord::Migration
  def change
    add_reference :preferences, :semester, index: true
  end
end
