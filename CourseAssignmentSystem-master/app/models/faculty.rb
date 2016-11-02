class Faculty < ActiveRecord::Base
	has_many :faculty_courses, :dependent => :destroy
	has_many :courses_assignments, :dependent => :destroy
	has_many :faculty_prefrences, :dependent => :destroy
end
