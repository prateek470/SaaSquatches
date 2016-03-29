Feature: professor signup
 
Scenario: successfully sign up new user

  Given I am on the login page
  When I follow "Signup"
  Then I should be on the signup page
  When I fill in "Email" with "cc@email.com"
  And I fill in "First name" with "Cesar"
  And I fill in "Last name" with "Ch"
  And I fill in "Password" with "log"
  And I press "Create an account"
  Then I am on the home page
