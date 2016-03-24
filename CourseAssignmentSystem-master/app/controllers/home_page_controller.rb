class HomePageController < ApplicationController
  def professorhome
  	@semester = Semester.all
  end
  
  def home
    @semester = Semester.all
  end
  def addfaculty
	if params[:class] != nil && params[:class][:FacultyName] != ""
  		Faculty.create!(faculty_name: params[:class][:FacultyName])
	end
     #redirect_to root_path;
  end

  def addcourse
	if params[:class] != nil && params[:class][:CourseName] != ""
  		Course.create!(:course_name => params[:class][:CourseName], :CourseTitle => params[:class][:CourseTitle])
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
    @prof_name = params[:class][:FacultyName]

    newID1 = nil
    newID2 = nil
    newID3 = nil
    #Check if 
    if params[:class] !=nil &&params[:class][:time_slot_id1] !=""
      @params_time_slot1 = params[:class][:time_slot_id1]
      if !Preference.exists?(:time_slot_id => @params_time_slot1, :building_id=> '1',:semester_id=> @semester_id)
        
        Preference.create!(:time_slot_id=>@params_time_slot1, :building_id=> '1',:semester_id=> @semester_id)
        puts "New Preference Added"
      end
      pref1 = Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",@params_time_slot1, '1', @semester_id).select("id").take
      if pref1!=nil
        newID1 = pref1.id
      elsif
        puts "Preference 1 not found"
      end
    end
    
    if params[:class] !=nil &&params[:class][:time_slot_id2] !=""
      @params_time_slot2 = params[:class][:time_slot_id2]
      if !Preference.exists?(:time_slot_id => @params_time_slot2, :building_id=> '1', :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot2, :building_id=> '1', :semester_id=> @semester_id )
        puts "New Preference Added"
      end
      pref2 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",@params_time_slot2, '1', @semester_id).select("id").take
      if pref2!=nil
        newID2 = pref2.id
      elsif
        puts "Preference 2 not found"
      end
    end
    
    if params[:class] !=nil &&params[:class][:time_slot_id3] !=""
      @params_time_slot3 = params[:class][:time_slot_id3]
      if !Preference.exists?(:time_slot_id => @params_time_slot3, :building_id=> '1', :semester_id=> @semester_id)
        Preference.create!(:time_slot_id=>@params_time_slot3, :building_id=> '1', :semester_id=> @semester_id)
        puts "New Preference Added"
      end
      pref3 =  Preference.where("time_slot_id=? AND building_id = ? AND semester_id =?",@params_time_slot3, '1', @semester_id).select("id").take
      if pref3!=nil
        newID3 = pref3.id
      elsif
        puts "Preference 3 not found"
      end
    end
    
    if !FacultyPreference.exists?(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :semester_id=> @semester_id)
      FacultyPreference.create!(:preference1_id=>newID1 ,:preference2_id => newID2 ,:preference3_id=>newID3, :semester_id=> @semester_id)
      puts "New FacultyPreference Added"
    elsif
      puts"FacultyPreference Exists"
    end
    prof_pref = FacultyPreference.where("preference1_id=? AND preference2_id=? AND preference3_id=? AND semester_id=?",newID1,newID2,newID3,@semester_id).take
    if prof_pref !=nil
      prof_pref_id = prof_pref.id
      name_id = Faculty.where("faculty_name = ?", @prof_name).take.id
      Faculty.update(name_id, preference: prof_pref_id.to_s)
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

end
