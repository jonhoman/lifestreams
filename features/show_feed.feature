Feature: Show feed information
  In order to see the status of a feed
  As a user
  I want to view my feed's details

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed that has items
    And I am on the dashboard
    
  Scenario: View show feed page
    When I follow "example feed"
    Then I should see "example feed"
    And I should see "http://tanyahoman.com/feed"
    And I should see items

  Scenario: Number of clicks on an item are displayed
    Given an item has clicks
    When I view "example feed"
    Then I should see "example feed"
    And I should see "http://tanyahoman.com/feed"
    And I should see items
    And I should see "visited 0 times"
