Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Scenario: Stream created with a blog feed as the source and a twitter account as the destination
    Given I am on the new stream page
    When I fill in "Stream Name" with "Test Stream"
    And I press "Create Stream"
