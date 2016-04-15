class HomePageController < ApplicationController
   before_action :require_user,:check_permission, only: [:home, :addfaculty, :addcourse, :addsemester, :setsession, :createsemester]


  def home
    @semester = Semester.all
  end
  
  def resetuser
    @users = User.all
    
    if params[:class] != nil
      desired_user = params[:class][:selectedUser]
      name = @users.where(:id =>desired_user).select(:faculty_name).take.faculty_name.to_s
      User.destroy(desired_user)
      flash[:success] = "Reset Account for " + name
      redirect_to root_path
    end
  end
  
  def addfaculty
     
    @permissions = ["Admin", "User"]
  	if params[:class] != nil && params[:class][:FacultyName] != "" && params[:class][:permission] !=
    		Faculty.create!(faculty_name: params[:class][:FacultyName], permission: params[:class][:permission])
    		flash[:success] = "New Faculty Member added"
    		redirect_to root_path
    #elsif
      #flash[:error] = "Please enter Faculty Name"
      #redirect_to addfaculty_path
	 end
     
  end

  def addcourse
  	if params[:class] != nil && params[:class][:CourseName] != ""
    		Course.create!(:course_name => params[:class][:CourseName], :CourseTitle => params[:class][:CourseTitle], :course_size => params[:course_size][:course_size])
  	end
  end

  def addsemester
  end

  def setsession
  	session[:semester_id] = params[:class][:semester_id]
  	redirect_to root_path;
  end
  
 
  
  def addpreference
    if session[:semester_id] !=nil && session[:semester_id]!=""
      @timeslot = TimeSlot.all
      @semester_id = session[:semester_id]
      @faculty = Faculty.all
      
  
      newID1 = nil
      newID2 = nil
      newID3 = nil
      newID4 = nil
      newID5 = nil
      newID6 = nil
      newID7 = nil
      newID8 = nil
      newID9 = nil
      
      if params[:class] !=nil && params[:class][:FacultyName] !=""
        
        @prof_id = params[:class][:FacultyName]
        if !Faculty.exists?(:id=>@prof_id)
          flash[:error] = "Professor does not exist"
          redirect_to addpreference_path
        end
      end
      #Check if there are times selected 
      if params[:class] !=nil #&&params[:class][:time_slot_id1] !=""
        @params_time_slot1 = 1
        day_combo = TimeSlot.where(:id=>@params_time_slot1).select('day_combination_id').take.day_combination_id
        
        #check if preference exists
        if !Preference.exists?(:time_slot_id => @params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
          puts "New Preference Added"
        end
        pref1 = Preference.where(:time_slot_id=>@params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id).select(:id).take
        
        #Get preference ID for Faculty Preference
        if pref1!=nil
          newID1 = pref1.id
        elsif
          flash[:error]="Preference 1 not recorded..."
          redirect_to addpreference_path
        end
      end
      #repeated for second preference
      if params[:class] !=nil #&&params[:class][:time_slot_id2] !=""
        
          @params_time_slot2 = 2
          day_combo = TimeSlot.where(:id=>@params_time_slot2).select('day_combination_id').take.day_combination_id
  
        if !Preference.exists?(:time_slot_id => @params_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@params_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id )
        end
        pref2 =  Preference.where(:time_slot_id=>@params_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref2!=nil
          newID2 = pref2.id
        elsif
          flash[:error]="Preference 2 not recorded..."
          redirect_to addpreference_path
        end
      end
      #repeat for third preference
      if params[:class] !=nil #&&params[:class][:time_slot_id3] !=""
        @params_time_slot3 = 3
        day_combo = TimeSlot.where(:id=>@params_time_slot3).select('day_combination_id').take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @params_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@params_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref3 =  Preference.where(:time_slot_id=>@params_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref3!=nil
          newID3 = pref3.id
        elsif
          flash[:error]="Preference 3 not recorded..."
          redirect_to addpreference_path
        end
      end
      
       #repeat for fourth preference
      if params[:class] !=nil #&&params[:class][:time_slot_id4] !=""
        @params_time_slot4 = 4
        day_combo = TimeSlot.where(:id=>@params_time_slot4).select('day_combination_id').take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @params_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@params_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref4 =  Preference.where(:time_slot_id=>@params_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref4!=nil
          newID4 = pref4.id
        elsif
          flash[:error]="Preference 4 not recorded..."
          redirect_to addpreference_path
        end
      end
      
       #repeat for fifth preference
      if params[:class] !=nil #&&params[:class][:time_slot_id5] !=""
        @params_time_slot5 = 5
        day_combo = TimeSlot.where(:id=>@params_time_slot5).select('day_combination_id').take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @params_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@params_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref5 =  Preference.where(:time_slot_id=>@params_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref5!=nil
          newID5 = pref5.id
        elsif
          flash[:error]="Preference 5 not recorded..."
          redirect_to addpreference_path
        end
      end
      
      
      #repeate for 6th preferece
      if params[:class] !=nil #&&params[:class][:bad_time_slot_id1] !=""
        @params_time_slot6 = 6
        day_combo = TimeSlot.where(:id=>@time_slot6).select('day_combination_id').take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @time_slot6,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@time_slot6,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref6 =  Preference.where(:time_slot_id=>@time_slot6,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref6!=nil
          newID6 = pref6.id
        elsif
          flash[:error]="Preference 6 not recorded..."
          redirect_to addpreference_path
        end
      end
      
       #repeate for 7th preferece
      if params[:class] !=nil #&&params[:class][:bad_time_slot_id2] !=""
        @time_slot7 = 7
        day_combo = TimeSlot.where(:id=>@time_slot7).select(day_combination_id).take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @time_slot7,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@time_slot7,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref7 =  Preference.where(:time_slot_id=>@time_slot7,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref7!=nil
          newID7 = pref7.id
        elsif
          flash[:error]="Preference 7 not recorded..."
          redirect_to addpreference_path
        end
      end
      
      #repeate for 8th preferece
      if params[:class] !=nil #&&params[:class][:bad_time_slot_id3] !=""
        @time_slot8 = 8
        day_combo = TimeSlot.where(:id=>@time_slot8).select(:day_combination_id).take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @time_slot8,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@time_slot8,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref8 =  Preference.where(:time_slot_id=>@time_slot8,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref8!=nil
          newID8 = pref8.id
        elsif
          flash[:error]="Preference 8 not recorded..."
          redirect_to addpreference_path
        end
      end
      
       #repeate for 9th preferece
      if params[:class] !=nil #&&params[:class][:bad_time_slot_id4] !=""
        @time_slot9 = 9
        day_combo = TimeSlot.where(:id=>@time_slot9).select(:day_combination_id).take.day_combination_id
        
        if !Preference.exists?(:time_slot_id => @time_slot9,:day_combination_id=>day_combo, :building_id=> '1', 
                                  :semester_id=> @semester_id)
          Preference.create!(:time_slot_id=>@time_slot9,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        end
        pref9 =  Preference.where(:time_slot_id=>@time_slot9,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id).select(:id).take
        if pref9!=nil
          newID9 = pref7.id
        elsif
          flash[:error]="Preference 9 not recorded..."
          redirect_to addpreference_path
        end
      end
      
      
      
      #Create new Faculty Preference
      if !FacultyPreference.exists?(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :preference4_id => newID4, 
                                    :preference5_id => newID5, :preference6_id => newID6, :preference7_id => newID7, :preference8_id => newID8, :preference9_id => newID9,:semester_id=> @semester_id)
        FacultyPreference.create!(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :preference4_id => newID4, 
                                  :preference5_id => newID5, :preference6_id => newID6, :preference7_id => newID7, :preference8_id => newID8, :preference9_id => newID9, :bad_preference5_id => badNewID5, :semester_id=> @semester_id)
      end
      prof_pref = FacultyPreference.where(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :preference4_id => newID4, 
                                          :preference5_id => newID5, :preference6_id => newID6, :preference7_id => newID7, :preference8_id => newID8, :preference9_id => newID9, :semester_id=> @semester_id).take
      #link Faculty Preference to Faculty record
      if prof_pref !=nil
        prof_pref_id = prof_pref.id
        prof_name = Faculty.where(:id=>@prof_id).select(:faculty_name).take.faculty_name.to_s
        Faculty.update(@prof_id, preference: prof_pref_id.to_s)
        flash[:success]= "Updated Preference for " + prof_name
        redirect_to root_path
      else
        #flash[:error] = "Faculty Preference Not found..."
      end
    else
      flash[:error] = "Please choose semester"
      redirect_to root_path
    end
  end
  
  def createsemester
    success = false;
    if params[:class] != nil && params[:class][:SemesterTitle] != ""
  	semester = Semester.find_by(SemesterTitle: params[:class][:SemesterTitle])
	if semester == nil
		Semester.create_semester(params[:class][:SemesterTitle])
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
  
  def addclassroom
    if  params[:class] == nil || params[:class][:building_name] == "" || params[:class][:room_name] == "" || params[:class][:room_capacity] == "" 
       
    else
      @building = Building.find_or_create_by!(:building_name=>params[:class][:building_name])
      @room = Room.find_or_create_by!(:room_name=>params[:class][:room_name],:building_id=>@building.id)
      @room.Capacity =  params[:class][:room_capacity]
      @room.save
      flash[:success] = "Successfully Created/Updated Class"
      redirect_to root_path; 
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
