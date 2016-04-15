class PrefSummaryController < ApplicationController
	
#Method functions:
#1)Used to create @showPrefSummary Hashmap containing details like Faculty name,
#  courses,preferences and Faculty note
#2)Show preference details ordered by faculty name
def index
	if session[:semester_id] != nil && session[:semester_id] != ""
		@timeslot = TimeSlot.all
		@faculty = Faculty.all
		
		@goodtimes = Array.new
		@badtimes = Array.new

		if params[:class]!=nil

		
  		selected = params[:class][:selected_time]
  		selected_time = @timeslot.find_by_id(selected).as_json["time_slot"]
  		for faculty in @faculty
  		  fac_preference = faculty.preference
  		  if fac_preference !=nil
  		    facultyPreference = FacultyPreference.find_by_id(fac_preference)
		      preferences = facultyPreference.as_json(except: [:created_at,:updated_at,:faculty_course_id,:id])
		      prefid = preferences["preference1_id"]
		      for preference in preferences.keys
		        prefid = preferences[preference] 
  		      if prefid !=nil
  		        pref = Preference.find_by_id(prefid).as_json
  		        time = pref["time_slot_id"]
  		        timeslot = @timeslot.find_by_id(time).as_json
  		        if timeslot["time_slot"] ==selected_time
  		          @badtimes.push(faculty)
  		        else
  		          @goodtimes.push(faculty)
  		        end  
  		      else
  		        next  
  		      end
  		      
		      end
  		  else
  		    @goodtimes.push(faculty)
  		  end
  		end
    end
	else
			flash[:error] = "Please choose semester"
			redirect_to root_path
		end

	end
end
