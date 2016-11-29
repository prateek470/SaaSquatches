class FacultiesController < ApplicationController
  before_action :require_user,:check_permission, only: [:addfaculty, :index]
  
  def index
    @permissions = ["Admin", "User"]
    @faculties = Faculty.all.order(:faculty_name)
    @faculty = Faculty.order(:id)
    respond_to do |format|
      format.html
      format.csv {send_data @faculty.to_csv}
    end
  end
  
  def addfaculty
    @permissions = ["User", "Admin"]
  	if params[:class] != nil && params[:class][:FacultyName] != "" && params[:class][:permission] != nil
      if Faculty.exists?(faculty_name: params[:class][:FacultyName],permission: params[:class][:permission])
        flash[:error] = "Faculty already exists."
        redirect_to addfaculty_path
      elsif Faculty.exists?(faculty_name: params[:class][:FacultyName])
        if params[:class][:FacultyName] == "Super Admin"
          flash[:warning] = "Cannot change access level of Super Admin."
          redirect_to addfaculty_path
        else
          Faculty.where(faculty_name: params[:class][:FacultyName]).update_all(faculty_name: params[:class][:FacultyName], permission: params[:class][:permission])
          flash[:success] = "Faculty member Dr. "+params[:class][:FacultyName]+" permission changed to "+params[:class][:permission]
          redirect_to addfaculty_path
        end
      else
    		Faculty.create!(faculty_name: params[:class][:FacultyName], permission: params[:class][:permission])
    		flash[:success] = "New Faculty Member Dr. "+params[:class][:FacultyName]+" added."
    		redirect_to addfaculty_path
      end
    end
  end
  
  def show
    @faculty = Faculty.find(params[:id])
  end
  
  def destroy
    @id = params[:id]
    @faculty = Faculty.find_by id: @id
    if @faculty != nil && @faculty.permission == 'Admin' && @faculty.faculty_name == 'Super Admin'
      flash[:error] = "You cannot delete the Super Admin."
      redirect_to '/faculties'
    else
      flash[:success] = "Faculty member Dr. "+@faculty.faculty_name+" deleted."
      @faculty.destroy
      redirect_to '/faculties'
    end
  end
end