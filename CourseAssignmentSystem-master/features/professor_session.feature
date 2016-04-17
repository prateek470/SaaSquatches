Feature: Professor Log In

    As a professor
    So that I can insert my preferences
    I want to be able to login to the application
    
  
Scenario: successfully sign up, log in, and log out as a new normal user

  Given I am on the login page
  And the following faculties exist:
  |faculty_name| permission|
  |Walker Duncan |User|
  |Chen Jianer| User|
  |Amato Nancy|Admin|
  |Keyser John|Admin|
  And "Chen Jianer" is not an admin
  When I follow "Signup"
  Then I should be on the signup page
  When I select "Chen Jianer" from "sessionId"
  When I fill in "user[email]" with "cj@example.com"
  And I fill in "user[password]" with "AAA"
  And I press "singup_button"
  Then I am on the login page
  When I fill in "Email" with "cj@example.com"
  And I fill in "Password" with "AAA"
  And I click "login_btn"
  Then I am on professor home index page
  And I should see "Manage Your Preferences"
  When I follow "logout_link"
  Then I should be on the login page
  But I should not see "Manage Your Preferences"
  

