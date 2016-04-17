Feature: Administrator Login
  
  As an administrator
  So that I can create a course assignment schedule
  I want to be able to login with administrator privileges
  
Background: At least one user is already signed up
  
  Given the following faculty is signed up as an administrator
  |faculty_id  |faculty_name|email        |password_digest |
  |25          |Keyser John|kj@example.com|AAA|
    
    
Scenario: successfully sign up, log in, and log out as an administrator

  Given I am on the login page
  And the following faculties exist:
  |faculty_name|
  |Walker Duncan |
  |Chen Jianer|
  |Amato Nancy|
  |Keyser John|
  When I follow "Signup"
  Then I should be on the signup page
  When I select "Amato Nancy" from "sessionId"
  When I fill in "user[email]" with "an@example.com"
  And I fill in "user[password]" with "AAA"
  And I press "singup_button"
  Then I am on the login page
  When I fill in "Email" with "an@example.com"
  And I fill in "Password" with "AAA"
  And I click "login_btn"
  Then I am on the home page
  And I should see "Edit Faculty"
  When I follow "logout_link"
  Then I should be on the login page
  But I should not see "Edit Faculty"