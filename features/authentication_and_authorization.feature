Feature: Authentication and Authorization
  In order to have the system remember my info 
  An account holder
  Wants to authenticate 

  Scenario: Sign in successfully 
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should be on the user root page
    And I should see "Signed in successfully"

  Scenario: Sign out link visible on home page if signed in
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should be on the user root page
    And I should see "Sign out"

  Scenario: Signing out should redirect the user to the home page
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    When I follow "Sign out"
    Then I should be on the home page

  Scenario: Signing in with bad username should still be on the sign in page 
    Given I am a user with email "jon@example.com" and password "password"
    And I am on the new user session page
    And I fill in "Email" with "jon@"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should be on the new user session page
    And I should see "Invalid email or password."
     
  Scenario: Signing in with bad password should still be on the sign in page 
    Given I am a user with email "jon@example.com" and password "password"
    And I am on the new user session page
    And I fill in "Email" with "jon@example.com"
    And I fill in "Password" with "pass"
    And I press "Sign in"
    Then I should be on the new user session page
    And I should see "Invalid email or password."

  Scenario: Sign in/sign up link visible on home page if not signed in
    Given I am on the home page
    Then I should see "Sign up or sign in"

  Scenario: Dashboard and account settings links not visible on home page if not signed in
    Given I am on the home page
    Then I should see "Sign up or sign in"
    
  Scenario: Dashboard and account settings links visible on home page if not signed in
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    Then I should see "Dashboard" within "#session_actions"
    Then I should see "Account Settings"

  Scenario: Must be logged in to view streams page
    Given I am on the home page
    When I go to the streams page
    Then I should be on the new user session page

  Scenario: Must be logged in to view feeds page
    Given I am on the home page
    When I go to the feeds page
    Then I should be on the new user session page
