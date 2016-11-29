class Faculty < ActiveRecord::Base
	has_many :faculty_courses, :dependent => :destroy
	has_many :course_assignments, :dependent => :destroy
	has_many :faculty_preferences, :dependent => :destroy
	has_many :users, :dependent => :destroy

	def self.to_csv(options = {})
		attributes = %w{id faculty_name permission}
		 CSV.generate(options) do |csv|
	      csv << attributes
	      all.each do |faculty|
	        csv << faculty.attributes.values_at(*attributes)
	      end
	    end
	end
end