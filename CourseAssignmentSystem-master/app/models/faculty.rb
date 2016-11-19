class Faculty < ActiveRecord::Base
def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |faculty|
        csv << faculty.attributes.values_at(*column_names)
      end
    end
  end
 def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    faculty = find_by_id(row["id"]) || new
    faculty.attributes = row.to_hash.slice(*row.to_hash.keys)
    faculty.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::CSV.new(file.path, packed: nil, file_warning: :ignore)
  when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
	has_many :faculty_courses
	has_many :courses_assignments
	has_many :faculty_prefrences
end