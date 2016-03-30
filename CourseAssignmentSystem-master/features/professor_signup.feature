Feature: professor signup
 
Scenario: successfully sign up new user

  Given I am on the login page
  And the following faculties exist:
  |faculty_name|
  |Walker Duncan |
  |Chen Jianer|
  |Nicholas Mankus|
  When I follow "Signup"
  Then I should be on the signup page
  When I select "Nicholas Mankus" from "sessionId"
  When I fill in "user[email]" with "doom@aol.com"
  And I fill in "user[password]" with "fish"
  And I press "singup_button"
  Then I am on the login page