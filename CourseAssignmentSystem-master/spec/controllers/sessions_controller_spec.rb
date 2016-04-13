require 'rails_helper'

# This is a comment 

RSpec.describe SessionsController, type: :controller do

    describe 'logging in' do
    it 'should redirect to login page if user input is incorrect' do
      # test here
      post:create, {:session => {:email => "cav@tamu.edu", :password => "password"}}
      response.should redirect_to login_path
    end
    it 'should redirect to professor home page if user input is correct' do
      # test here
    end
    end
    
    describe 'logging out' do 
    it 'should redirect to login page if the user presses the Log Out button' do
      # test here
      post:destroy, nil, nil
      response.should redirect_to root_path
    end
    end
    
    describe 'signing up' do 
    it 'should redirect to sign up page if user input is not complete' do
      # test here
    end
    it 'should redirect to professor home page if user input is complete' do
      # test here
    end
    end
    
end
