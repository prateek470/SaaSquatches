Feature: Add a login functionality, so professors can log in and set their preferences
  
  As a professor
  So that I can insert my preferences
  I want to be able to login to the apllication
  
  Scenario: User creates account
  
  Given I am on the login page
  When I press "Sign Up"
  Then I should be on the signup page
  When I fill in "Email" with "cc@email.com"
  And I fill in "First Name" with "Cesar"
  And I fill in "Last Name" with "Ch"
  And I fill in "Password" with "log"
  Then I should be logged in on the professor home page
  
  Scenario: User logs out
  
  Given I am on the home page logged in
  When I press "Log Out"
  Then I should be on the login page
 