require 'rails_helper'

RSpec.describe UsersController, type: :controller do

   describe 'creating new user' do
    it 'should have the user in the session hash' do
    
    post :create, {:user => {:id => "2", :faculty_name=> "Shell Dylan",:faculty_id=>"40", :email => "mm@gmail.com", :password => "asdf"}}
    #User.should_receive(:new).with({:id => "2", :first_name => "Slim", :last_name => "Shady", :email => "mm@gmail.com", :password => "asdf"})
    (response.should redirect_to signup_path)
    
    end
    end
    
    describe 'new' do 
     it 'should do this' do   
     
     User.should_receive(:new)
     get :new, nil, nil
     end 
   end 

end
