Feature: Show feed information
  In order to see the status of a feed
  As a user
  I want to view my feed's details

  Background:
    Given I am a user
    And I sign in
    And I add a feed that has items
    And I am on the dashboard
    
  Scenario: View show feed page
    When I view my feed
    Then I should see the feed information

  @feed
  Scenario: Number of clicks on an item are displayed
    Given an item has clicks
    When I view my feed that has clicks
    Then I should see the feed information
    And I should see the number of clicks
