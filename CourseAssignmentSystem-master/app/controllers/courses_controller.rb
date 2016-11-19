class CoursesController < ApplicationController
	def index
    	@courses = Course.all.order(:course_name)
    	respond_to do |format|
      		format.html
      		format.csv { send_data @courses.to_csv }
      		format.xls
    	end
	end

	def addcourse
    
    @data = Course.select('course_name,courseTitle,course_size')
  	if params[:class] != nil && params[:class][:CourseName] != "" && params[:class][:CourseTitle] != "" && params[:class][:course_size] !=""
      if !Course.exists?(:course_name => params[:class][:CourseName])
        Course.create!(:course_name => params[:class][:CourseName], :CourseTitle => params[:class][:CourseTitle], :course_size => params[:class][:course_size])
        flash[:success]= params[:class][:CourseName] + " added to the courses"
      else
        Course.where(:course_name => params[:class][:CourseName]).update_all(:CourseTitle => params[:class][:CourseTitle], :course_size => params[:class][:course_size])
        flash[:success]= "Course " + params[:class][:CourseName] + " updated."
      end
    elsif params[:class] != nil && params[:class][:CourseName] == ""
      flash[:error]= "Course name cannot be empty!"
    elsif params[:class] != nil && params[:class][:CourseTitle] == ""
      flash[:error]= "Course title cannot be empty!"
    elsif params[:class] != nil && params[:class][:course_size] == ""
      flash[:error]= "Course size should be more than 0!"
    end
  end

  def import
  Course.import(params[:file])
  redirect_to '/addcourse', notice: "Courses succesfully imported."
  end
end
