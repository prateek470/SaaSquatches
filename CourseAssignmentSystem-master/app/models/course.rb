class Course < ActiveRecord::Base
	has_many :course_assignments, :dependent => :destroy
	has_many :faculty_courses
end
