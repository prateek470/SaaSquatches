class FacultiesController < ApplicationController
  def index
    @permissions = ["Admin", "User"]
    @faculties = Faculty.all.order(:id)
    @faculty = Faculty.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @faculty.to_csv }
      format.xls
    end
  end
  
  def addfaculty
    @permissions = ["User", "Admin"]
    if params[:class] != nil && params[:class][:FacultyName] != "" && params[:class][:permission] !=
      if Faculty.exists?(faculty_name: params[:class][:FacultyName],permission: params[:class][:permission])
          flash[:success] = "Faculty Member already added"
      else
        Faculty.create!(faculty_name: params[:class][:FacultyName], permission: params[:class][:permission])
        flash[:success] = "New Faculty Member added"
        redirect_to root_path
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

  def import
  Faculty.import(params[:file])
  redirect_to '/addfaculty', notice: "Faculties succesfully imported."
  end
end