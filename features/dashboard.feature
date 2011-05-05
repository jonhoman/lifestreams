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

  Scenario: User should see their streams 
    Given I add a stream 
    When I go to the dashboard
    Then I should see my stream
