Feature: Administrator Login
  
  As an administrator
  So that I can create a course assignment schedule
  I want to be able to login with administrator privileges

  
Background: At least one user is already signed up
  
  Given the following faculty is signed up as an administrator
  |faculty_name |email        |password |
  |Keyser John  |kj@email.com |AAA      | 
    
Scenario: successfully sign up new user

  Given I am on the login page
  And the following faculties exist:
  |faculty_name|
  |Walker Duncan |
  |Chen Jianer|
  |Nicholas Mankus|
  |John Keyser|
  When I follow "Signup"
  Then I should be on the signup page
  When I select "Nicholas Mankus" from "sessionId"
  When I fill in "user[email]" with "doom@aol.com"
  And I fill in "user[password]" with "fish"
  And I press "singup_button"
  Then I am on the login page
  
Scenario: The user logs in
 
  Given I am on the login page 
  When I fill in "Email" with "kj@email.com"
  And I fill in "Password" with "AAA"
  And I press "login_btn"
  Then I am on the home page
  And I should see "Course Assignment System"
  
Scenario: The user logs out
  
  Given I am logged in with creds "kj@email.com" and "AAA"
  And I am on the home page 
  And I should see "Course Assignment System"
  When I follow "logout_link"
  Then I should be on the login page
  But I should not see "Course Assignment System"
