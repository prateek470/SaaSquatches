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
      :title => self.title+",\n "+find_faculty(self.course_assignment_id),
      :start => start_at.rfc822,
      :end => end_at.rfc822,
      :allDay => allDay,
      :user_name => self.user_name,
      :url => Rails.application.routes.url_helpers.events_path(id),
      :color => calendar_color(self.course_assignment_id)
    }
  end

  def find_faculty(course_assignment_id)
    faculty_name = ""
    if course_assignment_id!=nil
      faculty_id = CourseAssignment.find(course_assignment_id).faculty_id
      if faculty_id!=nil
        faculty_name = Faculty.find(faculty_id).faculty_name
      end
    end
    return faculty_name
  end

  def calendar_color(course_assignment_id)
    
    faculty_id = CourseAssignment.find(course_assignment_id).faculty_id
    day_combination_id = CourseAssignment.find(course_assignment_id).day_combination_id
    time_slot_id = CourseAssignment.find(course_assignment_id).time_slot_id
    semester_id = CourseAssignment.find(course_assignment_id).semester_id

    if faculty_id!=nil && day_combination_id!=nil && time_slot_id!=nil && semester_id!=nil
      good_preference_id = Faculty.find(faculty_id).preference
      bad_preference_id = Faculty.find(faculty_id).bad_preference
      if good_preference_id!=nil
        all_good_pref_ids = FacultyPreference.find(good_preference_id)
      end
      if bad_preference_id!=nil
        all_bad_pref_ids = FacultyPreference.find(bad_preference_id)
      end
      #Check if good preference
      if all_good_pref_ids!=nil && isPreference(all_good_pref_ids,day_combination_id,time_slot_id,semester_id)
        return "green"
      elsif all_bad_pref_ids!=nil && isPreference(all_bad_pref_ids,day_combination_id,time_slot_id,semester_id)
        return "red"
      else
        return "default"
      end
    end
    return "default"
  end

  def isPreference(pref_ids,day_combination,time_slot,semester)
    pref = pref_ids.preference1_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference2_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference3_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference4_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference5_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference6_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference7_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference8_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference9_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference10_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference11_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    pref = pref_ids.preference12_id
    if pref != nil
      day_id = Preference.find(pref).day_combination_id
      time_id = Preference.find(pref).time_slot_id
      sem_id = Preference.find(pref).semester_id
      if day_id!=nil && time_id!=nil && sem_id!=nil && day_id==day_combination && time_id==time_slot && sem_id==semester
        return true
      end
    end
    return false
  end

  def self.to_csv(options = {})
    temp_fac_name = ""
    temp_title = ""
    temp_day_combo = ""
    temp_time_slot = ""
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
                  if (time.id == course.time_slot_id && day.id == course.day_combination_id && faculty.id == course.faculty_id) && (faculty.faculty_name!=temp_fac_name || event.title!=temp_title || day.day_combination!=temp_day_combo || time.time_slot!=temp_time_slot)
                    temp_fac_name = faculty.faculty_name
                    temp_title = event.title
                    temp_day_combo = day.day_combination
                    temp_time_slot = time.time_slot
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
