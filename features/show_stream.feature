Feature: Show stream information
  In order to see the status of a stream
  As a user
  I want to view my stream's details

  Background:
    Given I am a user
    And I sign in

  Scenario: View stream show page
    Given I create a stream with a feed and a twitter account
    And I am on the dashboard
    When I view my stream
    Then my stream has a feed and a twitter account

  Scenario: Show stream page contains feed items
    Given I create a stream with a feed and a twitter account
    And I am on the dashboard
    When I view my stream
    Then I should see items

  Scenario: Show stream page displays a maximum of 3 feed items
    Given I create a stream with a feed and a twitter account
    And I add 5 items to my feed
    When I view my stream
    Then I should see at most 3 items

  Scenario: Add categories to stream 
    Given I create a stream with a feed and a twitter account
    And I add categories to the stream
    When I view my stream
    Then I should see the categories I chose

