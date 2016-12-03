class HomePageController < ApplicationController
   before_action :require_user,:check_permission, only: [:home, :resetuser, :addfaculty, :addcourse, :addsemester, :addclassroom, :setsession, :createsemester, :addpreference]


  def home
    @semester = Semester.all
  end
  
  def resetuser
    @users = User.order(faculty_name: :asc)
    
    if params[:class] != nil
      desired_user = params[:class][:selectedUser]
      if session[:user_id].to_s == desired_user.to_s
        flash[:error] = "Don't be silly. You can't delete yourself. :) "
        redirect_to resetuser_path
      else
        name = @users.where(:id =>desired_user).select(:faculty_name).take.faculty_name.to_s
        if name == "Super Admin"
          flash[:error] = "You cannot reset Super Admin."
          redirect_to resetuser_path
        else
          User.destroy(desired_user)
          flash[:success] = "Reset Account for " + name
          redirect_to root_path
        end
      end
    end
  end

  def addcourse
    @data = Course.select('id,course_name,course_title,course_size').order(course_name: :asc)
  	if params[:class] != nil && params[:class][:CourseName] != "" && params[:class][:course_title] != "" && params[:class][:course_size] !=""
      if !Course.exists?(:course_name => params[:class][:CourseName])
        Course.create!(:course_name => params[:class][:CourseName], :course_title => params[:class][:course_title], :course_size => params[:class][:course_size])
        flash[:success]= params[:class][:CourseName] + " added to the courses"
      else
        Course.where(:course_name => params[:class][:CourseName]).update_all(:course_title => params[:class][:course_title], :course_size => params[:class][:course_size])
        flash[:success]= "Course " + params[:class][:CourseName] + " updated."
      end
    elsif params[:class] != nil && params[:class][:CourseName] == ""
      flash[:error]= "Course name cannot be empty!"
    elsif params[:class] != nil && params[:class][:course_title] == ""
      flash[:error]= "Course title cannot be empty!"
    elsif params[:class] != nil && params[:class][:course_size] == ""
      flash[:error]= "Course size should be more than 0!"
    end
  end
  
  def delete_course
    @course = Course.find(params[:id])
    #Delete Course from Faculty courses table too
    faculties = FacultyCourse.where(:course1_id => @course.id)
    faculties.each do |faculty|
      faculty.course1_id = nil
      faculty.save!
    end
    faculties = FacultyCourse.where(:course2_id => @course.id)
    faculties.each do |faculty|
      faculty.course2_id = nil
      faculty.save!
    end
    faculties = FacultyCourse.where(:course3_id => @course.id)
    faculties.each do |faculty|
      faculty.course3_id = nil
      faculty.save!
    end
    #Now destroy the course 
    @course.destroy
    flash[:danger] = "Course successfully deleted."
    redirect_to addcourse_path
  end

  def addsemester
    @year = 2015
    if session[:semester_id] !=nil && session[:semester_id]!=""
      curr_sem = Semester.find(session[:semester_id])
      if curr_sem != nil && curr_sem != ""
        @year = curr_sem.semester_title.to_s.split(' ')[1].to_i
      end
    end
    @semesters = ["Fall", "Summer", "Spring"]
  end

  def setsession
    session[:semester_id] = params[:class][:semester_id]
    redirect_to root_path;
  end
  
  
  def addpreference
    if session[:semester_id] !=nil && session[:semester_id]!=""
      @good_pref_times = Array.new
      @bad_pref_times = Array.new

      if params[:faculty_id]!=nil && params[:faculty_id]!="" 
        good_pref_id = Faculty.find(params[:faculty_id]).preference
        if good_pref_id!=nil
          facultyPreference = FacultyPreference.find(good_pref_id)
          preferences = facultyPreference.as_json(except: [:created_at,:updated_at,:faculty_course_id,:id,:faculty_id,:semester_id])
          if preferences!=nil
            for preference in preferences.keys
              prefid = preferences[preference]
              if prefid != nil
                time = Preference.find(prefid).time_slot_id
                timeslot = TimeSlot.find(time)
                if timeslot != nil
                  daycombo = DayCombination.find(timeslot.day_combination_id)
                  if daycombo!=nil
                    @good_pref_times.push(daycombo.day_combination + " " + timeslot.time_slot)
                  end
                end
              end
            end
          end
        end

        bad_pref_id = Faculty.find(params[:faculty_id]).bad_preference
        if bad_pref_id!=nil
          facultyPreference = FacultyPreference.find(bad_pref_id)
          preferences = facultyPreference.as_json(except: [:created_at,:updated_at,:faculty_course_id,:id,:faculty_id,:semester_id])
          if preferences!=nil
            for preference in preferences.keys
              prefid = preferences[preference]
              if prefid != nil
                time = Preference.find(prefid).time_slot_id
                timeslot = TimeSlot.find(time)
                if timeslot != nil
                  daycombo = DayCombination.find(timeslot.day_combination_id)
                  if daycombo!=nil
                    @bad_pref_times.push(daycombo.day_combination + " " + timeslot.time_slot)
                  end
                end
              end
            end
          end
        end
      end

      @timeslot = TimeSlot.all
      @semester_id = session[:semester_id]
      @faculty = Faculty.order(faculty_name: :asc)
      @defaultBad = Array.new

      @preferred_no = Systemvariable.find_by(:name => 'num_pref_accept').value.to_i
      @unacceptable_no = Systemvariable.find_by(:name => 'num_pref_unaccept').value.to_i
      
      for slot in @timeslot
        if slot.time_slot.to_s.include?("*")
          @defaultBad.push(slot)
        end
      end
      goodPreference = Array.new(@preferred_no)
      badPreference = Array.new(@unacceptable_no)
      
      preferencesGoodArray = Array.new(@preferred_no)
      preferencesBadArray = Array.new(@unacceptable_no)
      if params[:class]!=nil
        if params[:class][:FacultyName] !=""
          if params.has_key?(:class) && (params.has_key?(:unacceptable_ids) || params.has_key?(:preferred_ids))          
            if params[:class] !=nil && params[:class][:FacultyName] !=nil         
              @prof_id = params[:class][:FacultyName]
             
              if !Faculty.exists?(:id=>@prof_id)
                flash[:error] = "Professor does not exist"
                redirect_to addpreference_path
              end
             
               
    
             
           end
            if params.has_key?(:preferred_ids)
              count = 0
              for time in params[:preferred_ids]
                goodPreference[count] = time
                count +=1
              end
            end
            if params.has_key?(:unacceptable_ids)
              count = 0
              for time in params[:unacceptable_ids]
                badPreference[count] = time
                count +=1
              end
            end
            count = 0
            for time in goodPreference
              if time == nil
                next
              end
              day_combo = TimeSlot.where(:id=>time).select(:day_combination_id).take.day_combination_id
              if !Preference.exists?(:time_slot_id => @params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
                Preference.create!(:time_slot_id=>time,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
                puts "New Preference Added"
              end
              id = Preference.where(:time_slot_id=>time,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id).select(:id).take.id
              preferencesGoodArray[count] = id
              count +=1
            end
            
            count = 0
            for time in badPreference
              if time == nil
                next
              end
              day_combo = TimeSlot.where(:id=>time).select(:day_combination_id).take.day_combination_id
              if !Preference.exists?(:time_slot_id => @params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
                Preference.create!(:time_slot_id=>time,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
                puts "New Preference Added"
              end
              id = Preference.where(:time_slot_id=>time,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id).select(:id).take.id
              preferencesBadArray[count] = id
              count +=1
            end
            
            if !FacultyPreference.exists?(:preference1_id=>preferencesGoodArray[0],:preference2_id=>preferencesGoodArray[1],:preference3_id=>preferencesGoodArray[2],:preference4_id=>preferencesGoodArray[3],:preference5_id=>preferencesGoodArray[4],
                                          :preference6_id=>preferencesGoodArray[5],:preference7_id=>preferencesGoodArray[6],:preference8_id=>preferencesGoodArray[7],:preference9_id=>preferencesGoodArray[8],
                                          :preference10_id=>preferencesGoodArray[9],:preference11_id=>preferencesGoodArray[10],:preference12_id=>preferencesGoodArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id)
                                          
              FacultyPreference.create!(:preference1_id=>preferencesGoodArray[0],:preference2_id=>preferencesGoodArray[1],:preference3_id=>preferencesGoodArray[2],:preference4_id=>preferencesGoodArray[3],:preference5_id=>preferencesGoodArray[4],
                                        :preference6_id=>preferencesGoodArray[5],:preference7_id=>preferencesGoodArray[6],:preference8_id=>preferencesGoodArray[7],:preference9_id=>preferencesGoodArray[8],
                                        :preference10_id=>preferencesGoodArray[9],:preference11_id=>preferencesGoodArray[10],:preference12_id=>preferencesGoodArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id)
            end
              goodPref =FacultyPreference.where(:preference1_id=>preferencesGoodArray[0],:preference2_id=>preferencesGoodArray[1],:preference3_id=>preferencesGoodArray[2],:preference4_id=>preferencesGoodArray[3],:preference5_id=>preferencesGoodArray[4],
                                          :preference6_id=>preferencesGoodArray[5],:preference7_id=>preferencesGoodArray[6],:preference8_id=>preferencesGoodArray[7],:preference9_id=>preferencesGoodArray[8],
                                          :preference10_id=>preferencesGoodArray[9],:preference11_id=>preferencesGoodArray[10],:preference12_id=>preferencesGoodArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id).take 
             
             
             if !FacultyPreference.exists?(:preference1_id=>preferencesBadArray[0],:preference2_id=>preferencesBadArray[1],:preference3_id=>preferencesBadArray[2],:preference4_id=>preferencesBadArray[3],:preference5_id=>preferencesBadArray[4],
                                          :preference6_id=>preferencesBadArray[5],:preference7_id=>preferencesBadArray[6],:preference8_id=>preferencesBadArray[7],:preference9_id=>preferencesBadArray[8],
                                          :preference10_id=>preferencesBadArray[9],:preference11_id=>preferencesBadArray[10],:preference12_id=>preferencesBadArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id)
                                          
              FacultyPreference.create!(:preference1_id=>preferencesBadArray[0],:preference2_id=>preferencesBadArray[1],:preference3_id=>preferencesBadArray[2],:preference4_id=>preferencesBadArray[3],:preference5_id=>preferencesBadArray[4],
                                        :preference6_id=>preferencesBadArray[5],:preference7_id=>preferencesBadArray[6],:preference8_id=>preferencesBadArray[7],:preference9_id=>preferencesBadArray[8],
                                        :preference10_id=>preferencesBadArray[9],:preference11_id=>preferencesBadArray[10],:preference12_id=>preferencesBadArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id)
            end
              badPref =FacultyPreference.where(:preference1_id=>preferencesBadArray[0],:preference2_id=>preferencesBadArray[1],:preference3_id=>preferencesBadArray[2],:preference4_id=>preferencesBadArray[3],:preference5_id=>preferencesBadArray[4],
                                          :preference6_id=>preferencesBadArray[5],:preference7_id=>preferencesBadArray[6],:preference8_id=>preferencesBadArray[7],:preference9_id=>preferencesBadArray[8],
                                          :preference10_id=>preferencesBadArray[9],:preference11_id=>preferencesBadArray[10],:preference12_id=>preferencesBadArray[11], :faculty_id => @prof_id, :semester_id=> @semester_id).take
             
             
             if goodPref !=nil && badPref !=nil
              good_pref_id = goodPref.id
              bad_pref_id = badPref.id
              prof_name = Faculty.where(:id=>@prof_id).select(:faculty_name).take.faculty_name.to_s
              Faculty.update(@prof_id, preference: good_pref_id.to_s)
              Faculty.update(@prof_id, bad_preference: bad_pref_id.to_s)
              if !params.has_key?(:unacceptable_ids)
                Faculty.update(@prof_id, bad_preference: nil)
              end
              if !params.has_key?(:preferred_ids)
                Faculty.update(@prof_id, preference: nil)
              end
              
              flash[:success]= "Updated Preference for " + prof_name
              redirect_to addpreference_path
            end
            
            
          end
        else
          flash[:error] = "Please select professor"
          redirect_to addpreference_path
        end
        
      end
    else
      flash[:error] = "Please choose semester"
      redirect_to root_path
    end
  end
  
  def createsemester
    success = false;
    if params[:semester] != "" && params[:year] != ""
      semester_title = params[:semester]+" "+params[:year]
      semester = Semester.find_by(semester_title: semester_title)
      if semester == nil
        Semester.create_semester(semester_title)
        success = true
      end
    end

    if success == true
      flash[:success] = "Created new semester"
      redirect_to root_path;
    else
      flash[:error] = "Enter a valid and new semester"
      redirect_to addsemester_path;
    end
  end

  def numberpreference
    @pref = Systemvariable.find_by(:name => 'num_pref_accept')
    @unaccept = Systemvariable.find_by(:name => 'num_pref_unaccept')
    @is_enabled = Systemvariable.find_by(:name => 'num_pref_enabled')
    if params[:class] != nil
      if params[:class][:preferred_val] != "" && params[:class][:unacceptable_val] != ""
        if params[:class][:preferred_val].to_i < 0 || params[:class][:preferred_val].to_i > 12 || params[:class][:unacceptable_val].to_i < 0 || params[:class][:unacceptable_val].to_i > 12
          flash[:success] = "Please choose values between 1 to 12."
          redirect_to numberpreference_path
        else
          @pref.value = params[:class][:preferred_val].to_i
          @pref.save

          @unaccept.value = params[:class][:unacceptable_val].to_i
          @unaccept.save

          @is_enabled.value = params[:class][:enabled].to_i
          @is_enabled.save

          flash[:success] = "Updated number of preferences!"
          redirect_to root_path
        end
      elsif params[:class][:preferred_val] == "" || params[:class][:unacceptable_val] == ""
        flash[:success] = "Please put valid values!"
      end
    end
  end

  def addclassroom
    @allRooms = Room.select('room_name,capacity,building_id')
    @allBuildings = Building.select('building_name,id')
    if  params[:class] != nil && params[:class][:building_name] != "" && params[:class][:room_name] != "" && params[:class][:room_capacity] != "" 
      @building = Building.find_or_create_by!(:building_name=>params[:class][:building_name].upcase)
      @room = Room.find_or_create_by!(:room_name=>params[:class][:room_name],:building_id=>@building.id)
      @room.capacity =  params[:class][:room_capacity]
      @room.save
      flash[:success] = "Successfully added/updated classroom " +params[:class][:room_name]+ " in " + params[:class][:building_name].upcase+ " building"
      redirect_to addclassroom_path
    else if params[:class] != nil && (params[:class][:building_name] == "" || params[:class][:room_name] == "" || params[:class][:room_capacity] == "")
      flash[:error] = "Please enter all values before submission"
    end
  end
  
  def calendar
    #course_name =Course.where(:id => "1").select(:course_name).take.course_name.to_s
    #name = @users.where(:id =>desired_user).select(:faculty_name).take.faculty_name.to_s
    #name = User.where(:id =>"1").select(:faculty_name).take.faculty_name.to_s
    @course = Course.where(:id =>"1").select(:course_name).take.course_name.to_s
    @start = "2016-04-14T09:35:00"
    @end =  "2016-04-14T10:20:00"
    print "COURSE NAME \n"
    #print name + "\n"
    print @course
    print @start
    print @end
    print "------------------------------"
    
  end
end
end