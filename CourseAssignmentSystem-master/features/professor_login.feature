Feature: Add a login functionality, so professors can log in and set their preferences
  
  As a professor
  So that I can insert my preferences
  I want to be able to login to the application
  
Given I am on the login page 

And the following users exist:
 | First name  | Last name | Email         | Password |
 | Cesar       | Ch        | cc@email.com  | log      |


  Scenario: User Login
  When I fill in "Email" with "cc@email.com"
  And I fill in "Password" with "log"
  And I press "Login"
  Then I am on the home page
  
  Scenario: User logs out
  
  When I go to the home page
  When I follow "Log Out"
  Then I should be on the login page

 
  
 
 
 
 
  
  
  
  
  