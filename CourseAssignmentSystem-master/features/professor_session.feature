Feature: Professor Log In

    As a professor
    So that I can insert my preferences
    I want to be able to login to the application
    
Background: At least one user is already signed up
  
  Given the following faculty is signed up as a professor
  |faculty_name |email        |password |
  |Keyser John  |kj@email.com |AAA      | 
  
Scenario: The professor logs in
 
  Given I am on the login page 
  When I fill in "Email" with "kj@email.com"
  And I fill in "Password" with "AAA"
  And I press "login_btn"
  Then I am on the home page
  And I should see "Course Assignment System"
  
Scenario: The professor logs out
  
  Given I am logged in with creds "kj@email.com" and "AAA"
  And I am on the home page 
  And I should see "Course Assignment System"
  When I follow "logout_link"
  Then I should be on the login page
  But I should not see "Course Assignment System"
  

