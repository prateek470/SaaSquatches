Feature: Professor Log In

    As a professor
    So that I can insert my preferences
    I want to be able to login to the application
    
Background: At least one user is already signed up
  
  Given the following faculty is signed up as a professor
  |faculty_name|faculty_id |email        |password |
  |Huang John  |17         |kj@email.com |AAA      |  
  
Scenario: The professor logs in
 
  Given I am on the login page 
  When I fill in "Email" with "nick@tamu.edu"
  And I fill in "Password" with "AAA"
  And I press "login_btn"
  Then I am on the home page
  And I should see "Course Assignment System"
  
Scenario: The professor logs out
  
  Given I am logged in with creds "nick@tamu.edu" and "AAA"
  And I am on the home page 
  When I follow "logout_link"
  Then I should be on the login page
  But I should not see "Course Assignment System"
  

