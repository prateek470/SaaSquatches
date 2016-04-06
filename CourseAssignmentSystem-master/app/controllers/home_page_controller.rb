class HomePageController < ApplicationController
   before_action :require_user, only: [:home, :addfaculty, :addcourse, :addsemester, :setsession, :createsemester]


  def home
    @semester = Semester.all
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
     #redirect_to root_path;
  end

  def addsemester
  end

  def setsession
  	session[:semester_id] = params[:class][:semester_id]
  	redirect_to root_path;
  end
  
 
  
  def addpreference
    @timeslot = TimeSlot.all
    @semester_id = session[:semester_id]
    @faculty_names = Faculty.all
    

    newID1 = nil
    newID2 = nil
    newID3 = nil
    newID4 = nil
    newID5 = nil
    badNewID1 = nil
    badNewID2 = nil
    badNewID3 = nil
    badNewID4 = nil
    badNewID5 = nil
    
    if params[:class] !=nil && params[:class][:FacultyName] !=""
      
      @prof_id = params[:class][:FacultyName]
      if !Faculty.exists?(:id=>@prof_id)
        flash[:error] = "Professor does not exist"
        redirect_to addpreference_path
      end
    end
    #Check if there are times selected 
    if params[:class] !=nil &&params[:class][:time_slot_id1] !=""
      @params_time_slot1 = params[:class][:time_slot_id1]
      day_combo = TimeSlot.where(:id=>@params_time_slot1).select('day_combination_id').take.day_combination_id
      
      #check if preference exists
      if !Preference.exists?(:time_slot_id => @params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot1,:day_combination_id=>day_combo, :building_id=> '1',:semester_id=> @semester_id)
        puts "New Preference Added"
      end
      pref1 = Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",@params_time_slot1, '1', @semester_id).select("id").take
      
      #Get preference ID for Faculty Preference
      if pref1!=nil
        newID1 = pref1.id
      elsif
        flash[:error]="Preference 1 not recorded..."
        redirect_to addpreference_path
      end
    end
    #repeated for second preference
    if params[:class] !=nil &&params[:class][:time_slot_id2] !=""
      
        @params_time_slot2 = params[:class][:time_slot_id2]
        day_combo = TimeSlot.where(:id=>@params_time_slot2).select('day_combination_id').take.day_combination_id

      if !Preference.exists?(:time_slot_id => @params_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                              :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id )
      end
      pref2 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_time_slot2, '1', @semester_id).select("id").take
      if pref2!=nil
        newID2 = pref2.id
      elsif
        flash[:error]="Preference 2 not recorded..."
        redirect_to addpreference_path
      end
    end
    #repeat for third preference
    if params[:class] !=nil &&params[:class][:time_slot_id3] !=""
      @params_time_slot3 = params[:class][:time_slot_id3]
      day_combo = TimeSlot.where(:id=>@params_time_slot3).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      pref3 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_time_slot3, '1', @semester_id).select("id").take
      if pref3!=nil
        newID3 = pref3.id
      elsif
        flash[:error]="Preference 3 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for fourth preference
    if params[:class] !=nil &&params[:class][:time_slot_id4] !=""
      @params_time_slot4 = params[:class][:time_slot_id4]
      day_combo = TimeSlot.where(:id=>@params_time_slot4).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      pref4 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_time_slot4, '1', @semester_id).select("id").take
      if pref4!=nil
        newID4 = pref4.id
      elsif
        flash[:error]="Preference 4 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for fifth preference
    if params[:class] !=nil &&params[:class][:time_slot_id5] !=""
      @params_time_slot5 = params[:class][:time_slot_id5]
      day_combo = TimeSlot.where(:id=>@params_time_slot5).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      pref5 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_time_slot5, '1', @semester_id).select("id").take
      if pref5!=nil
        newID5 = pref5.id
      elsif
        flash[:error]="Preference 5 not recorded..."
        redirect_to addpreference_path
      end
    end
    
    
    #repeat for first bad preference
    if params[:class] !=nil &&params[:class][:bad_time_slot_id1] !=""
      @params_bad_time_slot1 = params[:class][:bad_time_slot_id1]
      day_combo = TimeSlot.where(:id=>@params_bad_time_slot1).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_bad_time_slot1,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_bad_time_slot1,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      badPref1 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_bad_time_slot1, '1', @semester_id).select("id").take
      if badPref1!=nil
        badNewID1 = badPref1.id
      elsif
        flash[:error]="Bad Preference 1 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for second bad preference
    if params[:class] !=nil &&params[:class][:bad_time_slot_id2] !=""
      @params_bad_time_slot2 = params[:class][:bad_time_slot_id2]
      day_combo = TimeSlot.where(:id=>@params_bad_time_slot2).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_bad_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_bad_time_slot2,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      badPref2 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_bad_time_slot2, '1', @semester_id).select("id").take
      if badPref2!=nil
        badNewID2 = badPref2.id
      elsif
        flash[:error]="Bad Preference 2 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for third bad preference
    if params[:class] !=nil &&params[:class][:bad_time_slot_id3] !=""
      @params_bad_time_slot3 = params[:class][:bad_time_slot_id3]
      day_combo = TimeSlot.where(:id=>@params_bad_time_slot3).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_bad_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_bad_time_slot3,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      badPref3 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_bad_time_slot3, '1', @semester_id).select("id").take
      if badPref3!=nil
        badNewID3 = badPref3.id
      elsif
        flash[:error]="Bad Preference 3 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for fourth bad preference
    if params[:class] !=nil &&params[:class][:bad_time_slot_id4] !=""
      @params_bad_time_slot4 = params[:class][:bad_time_slot_id4]
      day_combo = TimeSlot.where(:id=>@params_bad_time_slot4).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_bad_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_bad_time_slot4,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      badPref4 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_bad_time_slot4, '1', @semester_id).select("id").take
      if badPref4!=nil
        badNewID4 = badPref2.id
      elsif
        flash[:error]="Bad Preference 4 not recorded..."
        redirect_to addpreference_path
      end
    end
    
     #repeat for fifth bad preference
    if params[:class] !=nil &&params[:class][:bad_time_slot_id5] !=""
      @params_bad_time_slot5 = params[:class][:bad_time_slot_id5]
      day_combo = TimeSlot.where(:id=>@params_bad_time_slot2).select('day_combination_id').take.day_combination_id
      
      if !Preference.exists?(:time_slot_id => @params_bad_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                                :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_bad_time_slot5,:day_combination_id=>day_combo, :building_id=> '1', 
                            :semester_id=> @semester_id)
      end
      badPref5 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",
                                  @params_bad_time_slot5, '1', @semester_id).select("id").take
      if badPref5!=nil
        badNewID5 = badPref5.id
      elsif
        flash[:error]="Bad Preference 5 not recorded..."
        redirect_to addpreference_path
      end
    end
    
    
    #Create new Faculty Preference
    if !FacultyPreference.exists?(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :preference4_id => newID4, :preference5_id => newID5, :bad_preference1_id => badNewID1, :bad_preference2_id => badNewID2, :bad_preference3_id => badNewID3, :bad_preference4_id => badNewID4, :bad_preference5_id => badNewID5, :semester_id=> @semester_id)
      FacultyPreference.create!(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :preference4_id => newID4, :preference5_id => newID5, :bad_preference1_id => badNewID1, :bad_preference2_id => badNewID2, :bad_preference3_id => badNewID3, :bad_preference4_id => badNewID4, :bad_preference5_id => badNewID5, :semester_id=> @semester_id)
    end
    prof_pref = FacultyPreference.where("preference1_id=? AND preference2_id=? AND preference3_id=? AND preference4_id=? AND preference5_id=? AND bad_preference1_id=? AND bad_preference2_id=? AND bad_preference3_id=? AND bad_preference4_id=? AND bad_preference5_id=? AND semester_id=?",
                                          newID1,newID2,newID3,newID4,newID5,badNewID1,badNewID2,badNewID3,badNewID4,badNewID5,@semester_id).take
    #link Faculty Preference to Faculty record
    if prof_pref !=nil
      prof_pref_id = prof_pref.id
      prof_name = Faculty.where(:id=>@prof_id).select("faculty_name").take.faculty_name.to_s
      Faculty.update(@prof_id, preference: prof_pref_id.to_s)
      flash[:success]= "Updated Preference for " + prof_name
      redirect_to root_path
    else
      #flash[:error] = "Faculty Preference Not found..."
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
  
end
