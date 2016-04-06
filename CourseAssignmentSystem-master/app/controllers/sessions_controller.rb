class SessionsController < ApplicationController
def new
end

  def create 
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      prof_id = User.where(:id=>@user).select(:faculty_id).take.faculty_id.to_s
      @permission = Faculty.where(:id=>prof_id).select(:permission).take.permission.to_s
      session[:permission] = @permission
      session[:faculty_id] = prof_id
      session[:faculty_name] = @user.faculty_name

      if(@permission == 'User')
        redirect_to '/professorhome'
        flash[:success]= "Logged in as "+@user.faculty_name.to_s
      elsif(@permission =='Admin')
        redirect_to '/'
        flash[:success]= "Logged in as "+@user.faculty_name.to_s
      else
        redirect_to '/login'
        flash[:error] = 'Permission not granted. Contact Administrator'
      
      end
    else
      redirect_to '/login'
    end
  end

    #Logout
    def destroy
     session[:user_id] = nil
     redirect_to '/'
    end
end
