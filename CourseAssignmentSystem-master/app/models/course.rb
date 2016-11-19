class Course < ActiveRecord::Base
def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |course|
        csv << course.attributes.values_at(*column_names)
      end
    end
  end
	
	has_many :course_assignments, :dependent => :destroy
	has_many :faculty_courses, :dependent => :destroy
	has_many :faculty_preferences, :through => :faculty_courses, :dependent => :destroy
end
