Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Scenario: Stream created with a feed and a twitter account 
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed
    And I configure my twitter account
    And I follow "Add New Stream"
    When I fill in "Stream Name" with "Test Stream"
    And show me the page
    And I select "example feed" from "feed_id" 
    And I select "Test Account" from "Twitter Accounts" 
    And I press "Create Stream"
    Then I should be on the streams page
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
