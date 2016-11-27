class FacultiesController < ApplicationController
  before_action :require_user,:check_permission, only: [:addfaculty, :index]
  
  def index
    @permissions = ["Admin", "User"]
    @faculties = Faculty.all.order(:faculty_name)
  end
  
  def addfaculty
     
    @permissions = ["User", "Admin"]
  	if params[:class] != nil && params[:class][:FacultyName] != "" && params[:class][:permission] != nil
      if Faculty.exists?(faculty_name: params[:class][:FacultyName],permission: params[:class][:permission])
        flash[:error] = "Faculty already exists."
        redirect_to addfaculty_path
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
    @faculty.destroy
    redirect_to '/faculties'
  end
end