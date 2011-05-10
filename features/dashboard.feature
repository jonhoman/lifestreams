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

  Scenario: Streams display the feed and destinations they connect
    Given I create a stream with a feed and a twitter account
    When I go to the dashboard
    Then I should see my stream
    And I should what my streams connects 

  Scenario: Stream without any feeds or destinations
    Given I add a stream
    When I go to the dashboard
    Then I should not see any information about feeds
    Then I should not see any information about destinations
