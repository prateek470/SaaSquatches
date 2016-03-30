Feature: Add a login functionality, so professors can log in and set their preferences
  
  As a professor
  So that I can insert my preferences
  I want to be able to login to the application

Given the following users exist:
 | First name  | Last name | Email            | Password |
 | Dr.         | Doom      | doom@latvia.evil | fish     |

  Scenario: User Login
  Given I am on the login page
#  Given the following users exist:
#  | First name  | Last name | Email            | Password |
#  | Dr.         | Doom      | doom@latvia.evil | fish     |
  When I fill in "Email" with "doom@aol.com"
  And I fill in "Password" with "fish"
  And I press "Login"
  Then I am on the home page
  

 
  
 
 
 
 
  
  
  
  
  
