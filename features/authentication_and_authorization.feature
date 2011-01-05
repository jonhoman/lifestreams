Feature: Authentication and Authorization
  In order to have the system remember my info 
  An account holder
  Wants to authenticate 

  Scenario: Sign in successfully 
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should be on the home page
    And I should see "Signed in successfully"

  Scenario: Sign out link visible on home page if signed in
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should be on the home page
    And I should see "Sign out"

  Scenario: Sign in/sign up link visible on home page if not signed in
    Given I am on the home page
    Then I should see "Sign up or sign in"

  Scenario: Signing out should redirect the user to the home page
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    When I follow "Sign out"
    Then I should be on the home page
