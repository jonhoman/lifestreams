Feature: Dashboard interface
  In order to view all stream-related information in one place
  A user
  Wants a dashboard
  
  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: User goes to their dashboard
    When I go to the user root page
    Then I should be on the user root page
  
  Scenario: Non-authenticated tries to view a dashboard
    Given I follow "Sign out"
    When I go to the user root page
    Then I should be on the new user session page

  Scenario: User should see their configured twitter accounts
    Given I configure my twitter account
    When I go to the user root page
    Then I should see my configured twitter account

  Scenario: User should not see other users' configured twitter accounts
    Given I configure my twitter account
    And another user configures a twitter account
    When I go to the user root page
    Then I should see my configured twitter account
    And show me the page
    And I should not see the other user's twitter account
