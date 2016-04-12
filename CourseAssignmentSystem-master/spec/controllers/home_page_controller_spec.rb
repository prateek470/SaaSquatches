require 'rails_helper'
require 'spec_helper'
describe Preference do
  
  before :each do
    @preference = Preference.new "1" "1" "1" "1"
  end
  
end

 RSpec.describe HomePageController, type: :controller do
  
  
  # 0. Try to access home page without logging in
    describe "GET home" do
      it "Try to access home page without logging in" do
        get "home"
        expect(response).to have_http_status(:redirect)
      end
    end
 
  #  describe "add new faculty" do
  #    it "should call the model method to create new faculty" do
  #	  Faculty.should_receive(:create!).with({:faculty_name => "Faculty1", :permission=>"User"})
  #	  post :addfaculty, {:class => {:FacultyName => "Faculty1", :permission=>"User"}}
  #   end
  # end
#  
    describe "add new course" do
      it "should call the model method to create new course" do
	  Course.should_receive(:create!).with(:course_name => 'name', :CourseTitle => 'title')
	  post :addcourse, {:class => {:CourseName => "name",:CourseTitle => "title"}}
      end
    end
#  
   # describe 'setting semester id in session' do
	 # it 'should set the semester id in session and redirect to home page' do
		 # post :setsession, {:class => {:semester_id => '1'}}
		 # session[:semester_id].should == '1'
		 # response.should redirect_to root_path
	 # end
   # end
#  
#    describe 'creating new semester' do
	 # it 'should call model method to create new semester' do
		 # Semester.should_receive(:find_by)
		 # Semester.should_receive(:create_semester).with('test1')
		 # post :createsemester, {:class => {:SemesterTitle => 'test1'}}
	 # end
	 # it 'should check for valid input before creating new semester' do
		 # post :createsemester, {:class => {:SemesterTitle => ''}}
		 # response.should redirect_to addsemester_path
	 # end
   # end
#    
   # describe 'adding new preference' do
     # it 'should add a new preference'do
       # Preference.should_receive(:create!).with({:time_slot_id=>'1',:day_combination_id=>'1', :building_id=> '1',:semester_id=> '1'})
       # post :addpreference, {:class=>{:time_slot_id=>'1',:day_combination_id=>'1', :building_id=> '1',:semester_id=> '1'}}
     # end
   # end
   
   # describe 'adding new faculty preference' do
     # it 'should add a new faculty preference if it is new'do
     # FacultyPreference.should_receive(:create!).with(:preference1_id=>'99')
     # post :addpreference, {:class=>{:time_slot_id1=>'99'}}
   # end
   # end
   # Links to various pages:

=begin
   1. Add Courses and Faculty
  describe "GET course_and_faculty" do
    it "redirects to the Courses and Faculty page" do
      get :course_and_faculty
      expect(response).to have_http_status(:success)
    end
  end
=end


  # describe "GET addclassroom" do
    # it "returns http success" do
      # get :addclassroom
      # expect(response).to have_http_status(:success)
    # end
  # end
# 
# 
  # describe "GET faculty_preferences" do
    # it "redirects to the Faculty Preferences page" do
      # get :facultyprefs
      # expect(response).to have_http_status(:success)
    # end
  # end
# 
# 
  # describe "GET conflict_resolution" do
    # it "redirects to the Conflict Resolution page" do
      # get :conflict_resolution
      # expect(response).to have_http_status(:success)
    # end
  # end
# 
# 
  # describe "GET add_new_faculty" do
    # it "redirects to the Add New Faculty page" do
      # get :addfaculty
      # expect(response).to have_http_status(:success)
    # end
  # end
# 
# 
# 
    # describe "GET addpreference" do
      # it "redirects to the Add New Preference page" do
        # get :addpreference
        # expect(response).to have_http_status(:success)
      # end
    # end
#  
 end

