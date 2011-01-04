Feature: Authentication and Authorization
  In order to have the system remember my info 
  An account holder
  Wants to authenticate 

  Scenario: Sign out link visible on stream index page 
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should see "Sign out"
    
