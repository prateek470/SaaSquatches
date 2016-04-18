Feature: Administrator Login
  
  As an administrator
  So that I can create a course assignment schedule
  I want to be able to login with administrator privileges
  
  Background: At least one user is already signed up
  
    Given the faculty listed below exist:
      | faculty_name | permission | preference |
      | Leyk Teresa  | User       | -1         |
      | Huang Jeff   | User       | -1         |
  
    And the users listed below exist:
      | faculty_id | faculty_name | email          | password |
      | 1          | Leyk Teresa  | lt@example.com | AAA      |
      | 2          | Huang Jeff   | hj@example.com | BBB      |
    
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

