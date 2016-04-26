require 'rails_helper'

# This is a comment 

RSpec.describe ProfessorHomeController, type: :controller do
	before :each do
	session[:user_id] = '3'
	session[:permission] = 'User'
	end
	describe 'professorhome' do
		it 'should call the method' do
		get :professorhome
		end
	end
	describe 'professoraddpreference' do
	before :each do
     #session[:user_id] = '3'
	 session[:semester_id] = '1'
	 #session[:permission] = 'User'
   end
		it 'should add bad preferences to database' do
		get :professoraddpreference, :unacceptable_ids=>['15','16']
		end
		it 'should add good professor preferences to database' do
		get :professoraddpreference, :preferred_ids=>['1', '2', '3']
		end
	end
	describe 'viewpreferences' do
		it 'should redirect to home if no semester set' do
		post :viewpreferences
		response.should redirect_to professorhome_path
		end
		it 'should do nothing if semester is set' do
		session[:semester_id] = '1'
		post :viewpreferences
		end
	end
	describe 'profsetsession' do
		it 'should set the seesion and redirect to home' do
		post :profsetsession, {:class => {:semester_id => '1'}}
		session[:semester_id].should == '1'
		response.should redirect_to professorhome_path
		end
	end
end