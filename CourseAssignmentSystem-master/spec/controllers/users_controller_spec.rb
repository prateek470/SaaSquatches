require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'creating new user' do
    it 'should have the user in the session hash' do
        # test here
        User.should_recieve(:create!).with(:faculty_id=>"id",:faculy_name=>"name",:email=>"email",:password=>"password")
        post :users, {:user =>{:faculty_id=>"id",:faculty=>"name", :email=>"email"}}
    end
    end

end
