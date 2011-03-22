Feature: Show stream information
  In order to see the status of a stream
  As a user
  I want to view my stream's details

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: View stream show page
    Given I create a stream with a feed and a twitter account
    And I am on the dashboard
    When I follow "example stream"
    Then I should be on the stream page
    And I should see "example stream"
    And I should see "example feed"
    And I should see "test"
    And I should see "Recent Items"

  Scenario: Show stream page contains link to feed
    Given I create a stream with a feed and a twitter account
    And I am on the dashboard
    When I follow "example stream"
    And I follow "example feed"
    Then I should be on the feed page

  Scenario: Show stream page contains link to email list
    Given I create a stream with a feed and an email list 
    And I am on the dashboard
    When I follow "example stream"
    And I follow "example email list"
    Then I should be on the email list page

  Scenario: Show stream page contains link to facebook account
    Given I create a stream with a feed and a facebook account 
    And I am on the dashboard
    When I follow "example stream"
    Then I should see "Facebook Account"

  Scenario: Show stream page contains feed items
    Given I create a stream with a feed and a twitter account
    And I am on the dashboard
    When I follow "example stream"
    Then I should see "Recent Items"
    And I should see items

  Scenario: Show stream page displays a maximum of 3 feed items
    Given I create a stream with a feed and a twitter account
    And I add 3 items to my feed
    And I am on the dashboard
    When I follow "example stream"
    Then I should see "Recent Items"
    And I should see at most 3 items

  Scenario: View stream show page without a feed
    Given I create a stream with a feed and a twitter account
    And I remove the feed from the stream
    And I am on the dashboard
    When I follow "example stream"
    Then I should see "no feed"

  Scenario: View stream show page without a twitter account
    Given I create a stream with a feed and a twitter account
    And I remove the twitter account from the stream
    And I am on the dashboard
    When I follow "example stream"
    Then I should see "no twitter account"

  Scenario: Add categories to stream 
    Given I create a stream with a feed and a twitter account
    And I add categories to the stream
    And I am on the dashboard
    When I follow "example stream"
    Then I should be on the stream page
    And I should see "cat1, cat2"

