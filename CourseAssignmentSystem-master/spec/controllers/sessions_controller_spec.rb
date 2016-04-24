require 'rails_helper'

# This is a comment 

RSpec.describe SessionsController, type: :controller do
    describe 'create' do
	  before :each do
		#@mock_user = double(User, :id => 1, :faculty_id => '25', :faculty_name => 'Keyser John', :email => 'john@tamu.edu', :password => 'password')
		@users = [double(:id => 1, :faculty_id => '25', :faculty_name => 'Keyser John', :email => 'john@tamu.edu', :password => 'password')]
		@faculty = [double(:id => 25, :faculty_name => 'Keyser John', :permission => 'Admin')]
		session[:user_id] = @users[0].id
		session[:permission] = @faculty[0].permission
		session[:email] = @users[0].email
		session[:password] = @users[0].password
	  end
	  it 'should create a session based on who logs in' do
	  #post :create, {:user => {:id => 5, :faculty_name=> "Shell Dylan",:faculty_id=>"40", :email => "mm@gmail.com", :password => "asdf"}}
		#{:user => {:id => "2", :faculty_name=> "Shell Dylan",:faculty_id=>"40", :email => "mm@gmail.com", :password => "asdf"}, :faculty => {:id => 25, :faculty_name => 'Shell Dylan', :permission => 'User'}}
		#response.should redirect_to '/professorhome'
		
	    #User.should_receive(:find_by_email).with('john@tamu.edu').and_return(@users)
	  end
	end
	describe 'destroy' do
	  before :each do
        session[:user_id] = '1'
        session[:permission] = 'User'
      end
	  it 'should delete the current user and redirect to home' do
		get :destroy
		session[:user_id].should == nil
		response.should redirect_to root_path
	  end
	end
end
