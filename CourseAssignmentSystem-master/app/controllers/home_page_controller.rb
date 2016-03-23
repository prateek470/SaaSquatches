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
    if params[:class] !=nil &&params[:class][:time_slot_id1] !=""
      @params_time_slot1 = params[:class][:time_slot_id1]
      if !Preference.exists?(:time_slot_id => @params_time_slot1, :building_id=> '1')
        
        Preference.create!(:time_slot_id=>@params_time_slot1, :building_id=> "1")
      end
      newID1 = Preference.where(["time_slot_id=?",@params_time_slot1],["building_id=?", :building_id =>"1"]).select("id").first
    end
    if params[:class] !=nil &&params[:class][:time_slot_id2] !=""
      @params_time_slot2 = params[:class][:time_slot_id2]
      if !Preference.exists?(:time_slot_id => @params_time_slot2, :building_id=> '1')
        
        Preference.create!(:time_slot_id=>@params_time_slot2, :building_id=> "1")
      end
      newID2 = Preference.where(["time_slot_id=?",@params_time_slot2],["building_id=?", :building_id =>"1"]).select("id").first
    end
    
    if params[:class] !=nil &&params[:class][:time_slot_id3] !=""
      @params_time_slot3 = params[:class][:time_slot_id3]
      if !Preference.exists?(:time_slot_id => @params_time_slot3, :building_id=> '1')
        Preference.create!(:time_slot_id=>@params_time_slot3, :building_id=> "1")
      end
      newID3 = Preference.where(["time_slot_id=?",@params_time_slot3],["building_id=?", :building_id =>"1"]).select("id").first
    end
    FacultyPreference.create!(:preference1_id=>newID1.id.to_s() ,:preference2_id => newID2.id.to_s() ,:preference3_id=>newID3.id.to_s())

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
