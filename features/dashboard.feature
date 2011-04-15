Feature: Dashboard interface
  In order to view all stream-related information in one place
  A user
  Wants a dashboard
  
  Background:
    Given I am a user
    And I sign in

  Scenario: Non-authenticated tries to view a dashboard
    Given I am not logged in
    When I go to the dashboard
    Then I should be on the new user session page

  Scenario: User should see their configured twitter accounts
    Given I configure my twitter account
    When I go to the dashboard
    Then I should see my configured twitter account

  Scenario: User should not see other users' configured twitter accounts
    Given I configure my twitter account
    And another user configures a twitter account
    When I go to the dashboard
    Then I should see my configured twitter account
    And I should not see the other user's twitter account

  Scenario: User should see their feeds 
    Given I add a feed 
    When I go to the dashboard
    Then I should see my feed 

  Scenario: User should see their streams 
    Given I add a stream 
    When I go to the dashboard
    Then I should see my stream

  Scenario: User should see their email lists 
    Given I add an email list 
    When I go to the dashboard
    Then I should see my email list

  Scenario: User should see their configured facebook account
    Given I configure my facebook account 
    When I go to the dashboard
    Then I should see my configured facebook account
