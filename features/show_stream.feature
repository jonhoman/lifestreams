Feature: Show stream information
  In order to see the status of a stream
  As a user
  I want to view my stream's details

  Background: 
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed
    And I configure my twitter account
    And I add a stream

  @wip
  Scenario: View stream details show
    Given I am on the user root page
    When I follow "example stream"
    Then I should be on the stream page
