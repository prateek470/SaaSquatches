class SessionsController < ApplicationController
def new
end

  def create 
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # if !@user.email_confirmed
      #   flash[:error] = 'Please activate your account by following the 
      #   instructions in the account confirmation email you received to proceed'
      #   # redirect_to '/signup'
      #   # return
      # end
      session[:user_id] = @user.id
      #prof_id = User.where(:id=>@user).select(:faculty_id).take.faculty_id.to_s
      #prof_permission = Faculty.where(:id=>prof_id).select(:permission).take.permission.to_s
      faculty = Faculty.find_by_id(@user.faculty_id)
      if (faculty == nil)
        flash[:error] = "Faculty does not exist. Please signup."
        redirect_to '/signup'
        return
      end
      session[:permission] = faculty.permission #prof_permission
      session[:faculty_id] = faculty.id
      session[:faculty_name] = @user.faculty_name
      puts 
      if(session[:permission] == 'User')
        redirect_to '/professorhome'
        flash[:success]= "Logged in as "+@user.faculty_name.to_s
      elsif(session[:permission] =='Admin')
        redirect_to '/'
        flash[:success]= "Logged in as "+@user.faculty_name.to_s
      else
        redirect_to '/login'
        flash[:error] = 'Permission not granted. Contact Administrator'
      end
    else
      flash[:error] = 'Email or Password not valid'
      redirect_to '/login'
    end
  end

    #Logout
    def destroy
     session[:user_id] = nil
     redirect_to '/'
    end
end
