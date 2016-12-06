class UsersController < ApplicationController
def new
    @user = User.new
    @faculty_names = Faculty.all
end

def create
  user_name = Faculty.where(:id=>params[:user][:faculty_id]).select(:faculty_name).take.faculty_name.to_s
  if !User.exists?(:faculty_id=>params[:user][:faculty_id])
    @user = User.new(user_params)
    if @user.save
      @user.update(faculty_name: user_name)
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue."
      redirect_to login_path
    elsif User.exists?(:email=>params[:user][:email].downcase)
      flash[:error] = "Email Already Exists! For more help, contact Admin."
      redirect_to signup_path
    else
      flash[:error] = "Please enter correct Sign-up info."
      redirect_to signup_path
    end
  else
    flash[:error] = "User Already Exists! Please contact Admin."
    redirect_to signup_path 
  end
end

 # def destroy
  # User.find(params(:user_id).destroy
  # redirect_to '/signup'
 # end

def confirm_email
  user = User.find_by_confirm_token(params[:id])
  if user
    user.email_activate
    flash[:success] = "Welcome to the TAMU Course Assignment System! Your email has been confirmed.\n
    Please sign in to continue."
    redirect_to '/login'
  else
    flash[:error] = "Sorry. User does not exist or already activated."
    redirect_to '/login'
  end
end

private
  def user_params
    params.require(:user).permit(:faculty_id, :faculty_name, :email, :password)
  end
end
