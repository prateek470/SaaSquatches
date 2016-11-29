class Event < ActiveRecord::Base
     # scope :between, lambda {|start_time, end_time| {:conditions => ["? < starts_at and starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)] }}
  def self.between(start_time, end_time)
    where('start_at > :lo and start_at < :up',
      :lo => Event.format_date(start_time),
      :up => Event.format_date(end_time)
    )
  end

  def self.format_date(date_time)
   Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :start => start_at.rfc822,
      :end => end_at.rfc822,
      :allDay => allDay,
      :user_name => self.user_name,
      :url => Rails.application.routes.url_helpers.events_path(id),
      :color => "green"
    }
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Faculty Name","Course-Building-Room","Day","Time Slot"]
      all.each do |event|
        course_assignment_ids = CourseAssignment.where(:id => event.course_assignment_id)
        course_assignment_ids.each do |course|
          if (course.id == event.course_assignment_id)
            faculties = Faculty.where(:id => course.faculty_id)
            days = DayCombination.where(:id => course.day_combination_id)
            times = TimeSlot.where(:id => course.time_slot_id)
            faculties.each do |faculty|
              days.each do |day|
                times.each do |time|
                  if(time.id == course.time_slot_id && day.id == course.day_combination_id && faculty.id == course.faculty_id)
                    csv << [faculty.faculty_name, event.title, day.day_combination, time.time_slot]
                  end
                end
              end
            end  
          end
        end
      end
    end
  end
end
