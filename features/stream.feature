Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Scenario: Stream created with a blog feed as the source and a twitter account as the destination
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I am on the new stream page
    When I fill in "Stream Name" with "Test Stream"
    And I fill in "Source Name" with "Test Source" 
    And I fill in "Source URL" with "Test URL"
    And I press "Create Stream"
    Then I should be on the streams page
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And I should have the following fields stored for the source:
      |Name        | Feed URL |
      |Test Source | Test URL |
