require 'rails_helper'

RSpec.describe FacultiesController, type: :controller do
  before :all do
    User.create(:id => '2', :faculty_name=> 'Shell Dylan', :faculty_id=> '40', :email => 'mm@gmail.com', :password => 'asdf')
    User.create(:id => '3', :faculty_name=> 'Da Silva Dilma', :faculty_id=> '7', :email => 'nn@gmail.com', :password => 'asdf')
  end
  describe 'add new faculty' do
    it 'should call the model method to create new faculty' do
      session[:user_id] = '3'
      session[:FacultyName] = '3'
      session[:permission] = 'Admin'
      post :addfaculty, {:class => {:faculty_name => 'Faculty1', :permission=>'User'}}
      response.should redirect_to root_path
    end
    after :all do
      @added_faculty = Faculty.find_by(faculty_name: nil)
      @f_id = @added_faculty.id
      Faculty.delete(@f_id)
    end
  end
end
