Link to heroku app: http://tamucs.herokuapp.com/

Ruby Version: 2.3.1
Rails Version: 4.2.4



Summary

The main customer need is to create a system which eases the course assignment process each semester. We have classrooms with available time slots and capacity, faculties to assign courses, courses have course size and faculty have their preferred and unacceptable timings. The customer wants to assign a course to a faculty based on the faculty preferred and acceptable timing and not by faculty unacceptable timings.

Finally, customer/admin should be able to see a final calendar which courses assigned to each faculty with color coding based on faculty preferred, acceptable and unacceptable timings. The customer also wants faculties to have separate accounts to edit their preferences and check their final calendar.

The application we have developed is divided into 4 main parts to solve the customer need.

Admin User can:
1.	Manage Faculty Info: Admin can add/edit faculty, edit preferences, change number of preferences, and reset faculty account.
2.	Edit Courses and Classroom: Admin can add/edit classrooms and courses, add a new semester and add room timings.
3.	Make assignments: Admin can assign courses to faculties and schedule course for each faculty.
4.	View: Admin can check the faculty preferred timings and final calendar. Admin can also export the final calendar as a csv file.

Each faculty can:
1.	Edit Preferences: User can edit their preferred timings and mark each time slot as preferred, acceptable, and unacceptable. User can change the preferred timings until admin will disable the option to edit timing.
2.	Current Preferences: User can check the current preferred timings even after disabling the edit preferences by admin.
3.	Courses assigned: User/Faculty can see which course is assigned in calendar view and whether that course is as per the preferred timing or in unacceptable timing. Preferred time will be shown in green color, acceptable in blue color and unacceptable in red color.

Admin can manage a list of courses for each semester. The course name cannot be duplicated with other courses and at any point of time, admin can modify course name and its capacity.

Gems

We have used many GEMs in our project. Some of the main tools/Gem are explained below.
1.	Coffee-rails: Use CoffeeScript for .coffee assets and views
2.	Jquery-rails: Use jquery as the JavaScript library
3.	Fullcalendar-rails: Used to generate the final calendar view.
4.	Browser_detect: To handle browser specific functionalities.
5.	Rspec-rails: To generate rspec test code coverage.
6.	Simplecov: Code coverage analysis tools for Ruby.
7.	Cucumber-rails: Code coverage analysis tools for Ruby.

Video Interview with customer: https://vimeo.com/195012516

Heroku deployment (completed legacy project)
Heroku link: http://tamucs.herokuapp.com 
Admin login: prateek470@gmail.com
Password: ****

User login: examplecas1@tamu.edu
Password: ****
