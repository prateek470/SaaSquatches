class ProfessorHomeController < ApplicationController
  
   before_action :require_user, only: [:professorhome, :professoraddpreference, :profsetsession]

  def professorhome
    @semester = Semester.all
  end
  

  def professoraddpreference
    @is_enabled = Systemvariable.find_by(:name => 'num_pref_enabled')
    if (@is_enabled != nil && @is_enabled.value == '0')
      flash[:error] = "Preference setting is disabled!"
      redirect_to professorhome_path
      return
    end
    if session[:semester_id] !=nil && session[:semester_id]!=""
      @timeslot = TimeSlot.all
      @semester_id = session[:semester_id]
      @faculty = Faculty.all
      @defaultBad = Array.new
      @preferred_no = Systemvariable.find_by(:name => 'num_pref_accept').value.to_i
      @unacceptable_no = Systemvariable.find_by(:name => 'num_pref_unaccept').value.to_i

      flash[:success] = "You can only choose " + @preferred_no.to_s + " Preferred and " +@unacceptable_no.to_s+ " Unacceptable timings!"
      for slot in @timeslot
        if slot.time_slot.to_s.include?("*")
          @defaultBad.push(slot)
        end
      end
      goodPreference = Array.new(@preferred_no)
      badPreference = Array.new(@unacceptable_no)
      
      preferencesGoodArray = Array.new(@preferred_no)
      preferencesBadArray = Array.new(@unacceptable_no)
 
      if params.has_key?(:unacceptable_ids) || params.has_key?(:preferred_ids)          
        @prof_id = session[:faculty_id]
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
          redirect_to professorhome_path
        end
        
        
      end
    else
      flash[:error] = "Please choose semester"
      redirect_to professorhome_path
    end
  end
  
  def viewpreferences
    @timeslot = TimeSlot.all
    @goodtimes = Array.new
    @badtimes = Array.new
    
    if session[:semester_id] !=nil && session[:semester_id]!=""  
      faculty_id = session[:faculty_id]
      faculty = Faculty.find(faculty_id)
      if faculty==nil
        flash[:error] = "No faculty found"
        return
      end
      
      fac_preference = faculty.preference
      if fac_preference !=nil
        facultyPreference = FacultyPreference.find(fac_preference)
        preferences = facultyPreference.as_json(except: [:created_at,:updated_at,:faculty_course_id,:id,:faculty_id,:semester_id])
        if preferences!=nil
          for preference in preferences.keys
            prefid = preferences[preference]
            if prefid != nil
              time = Preference.find(prefid).time_slot_id
              timeslot = @timeslot.find(time)
              if timeslot != nil
                daycombo = DayCombination.find(timeslot.day_combination_id)
                if daycombo!=nil
                  @goodtimes.push(daycombo.day_combination + " " + timeslot.time_slot)
                end
              end
            end
          end
        end
      end

      bad_preference = faculty.bad_preference
      if bad_preference !=nil
        facultyPreference = FacultyPreference.find_by_id(bad_preference)
        preferences = facultyPreference.as_json(except: [:created_at,:updated_at,:faculty_course_id,:id,:faculty_id,:semester_id])
        if preferences!=nil
          for preference in preferences.keys
            prefid = preferences[preference] 
            if prefid !=nil
              time = Preference.find_by_id(prefid).time_slot_id
              timeslot = @timeslot.find_by_id(time)
              if timeslot != nil
                daycombo = DayCombination.find(timeslot.day_combination_id)
                if daycombo!=nil
                  @badtimes.push(daycombo.day_combination + " " + timeslot.time_slot)
                end
              end
            end
          end    
        end
      end
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
