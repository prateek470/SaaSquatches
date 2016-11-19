class Faculty < ActiveRecord::Base
def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |faculty|
        csv << faculty.attributes.values_at(*column_names)
      end
    end
  end
	has_many :faculty_courses
	has_many :courses_assignments
	has_many :faculty_prefrences
end