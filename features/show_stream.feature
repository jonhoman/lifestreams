Feature: Show stream information
  In order to see the status of a stream
  As a user
  I want to view my stream's details

  Scenario: View stream show page
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I create a stream with a feed and a twitter account
    And I am on the user root page
    When I follow "example stream"
    Then I should be on the stream page
    And I should see "example stream"
    And I should see "example feed"
    And I should see "test"
    And I should see "Recent Items"

  Scenario: Show stream page contains link to feed
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I create a stream with a feed and a twitter account
    And I am on the user root page
    When I follow "example stream"
    And I follow "example feed"
    Then I should be on the feed page

  Scenario: View stream show page without a feed
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I create a stream with a feed and a twitter account
    And I remove the feed from the stream
    And I am on the user root page
    When I follow "example stream"
    Then I should see "no feed"

  Scenario: View stream show page without a twitter account
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I create a stream with a feed and a twitter account
    And I remove the twitter account from the stream
    And I am on the user root page
    When I follow "example stream"
    Then I should see "no twitter account"
