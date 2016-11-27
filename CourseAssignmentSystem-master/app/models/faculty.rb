class Faculty < ActiveRecord::Base
	has_many :faculty_courses, :dependent => :destroy
	has_many :course_assignments, :dependent => :destroy
	has_many :faculty_preferences, :dependent => :destroy
	has_many :users, :dependent => :destroy
end