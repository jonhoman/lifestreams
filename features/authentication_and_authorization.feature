Feature: Authentication and Authorization
  In order to have the system remember my info 
  An account holder
  Wants to authenticate 

  Scenario: Sign in successfully 
    Given I am a user
    And I sign in
    Then I should be on the dashboard
    And I should see that I have signed in

  Scenario: Sign out link visible on home page if signed in
    Given I am a user
    And I sign in
    Then I should be on the dashboard
    And I should be able to sign out

  Scenario: Signing out should redirect the user to the home page
    Given I am a user
    And I sign in
    When I sign out
    Then I should be on the home page

  Scenario: Signing in with bad username should still be on the sign in page 
    Given I am a user
    And I am on the new user session page
    When I sign in with a bad email address
    Then I should be on the new user session page
    And I should see that I submitted a bad email or password
     
  Scenario: Signing in with bad password should still be on the sign in page 
    Given I am a user
    And I am on the new user session page
    When I sign in with a bad email address
    Then I should be on the new user session page
    And I should see that I submitted a bad email or password

  Scenario: Sign in/sign up link visible on home page if not signed in
    Given I am on the home page
    Then I should be able to sign up or sign in

  Scenario: Dashboard and account settings links visible on home page if signed in
    Given I am a user
    And I sign in
    Then I should see links to the dashboard and account settings

  Scenario: Must be logged in to view dashboard 
    Given I am on the home page
    When I go to the dashboard
    Then I should be on the new user session page
