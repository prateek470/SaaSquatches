class ProfessorHomeController < ApplicationController
  
   before_action :require_user, only: [:professorhome, :addprofessorpreference, :profsetsession]
   
  def professorhome
    @semester = Semester.all
  end

  
  
  def professoraddpreference
    if session[:semester_id] !=nil && session[:semester_id]!="" 
      @timeslot = TimeSlot.all
      @semester_id = session[:semester_id]
      @faculty_names = Faculty.all
      
      
      newID1 = nil
      newID2 = nil
      newID3 = nil
      newID4 = nil
      newID5 = nil
      newID6 = nil
      newID7 = nil
      newID8 = nil
      newID9 = nil
      
      @prof_id = session[:faculty_id]
      if !Faculty.exists?(:id=>@prof_id)
        flash[:error] = "Professor does not exist"
        redirect_to addpreference_path
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
  
  def viewpreferences
    if session[:semester_id] !=nil && session[:semester_id]!=""  
     @course =  'BANANA'
     @start = '2016-04-13T09:00:00'
     @end = '2016-04-13T09:50:00'
    else
      flash[:error] = "Please choose semester"
      redirect_to professorhome_path
    end
  end
  def profsetsession
    session[:semester_id] = params[:class][:semester_id]
    redirect_to professorhome_path
  end
 

 

end
