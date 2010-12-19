Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Scenario: Stream created with a blog feed as the source and a twitter account as the destination
    Given I am on the home page
    And I click the new stream link
    When I fill in "Name" with "Test Feed"
    And I fill in "Source URL" with "http://test.com/feed"
    And I press "Create Source"
    Then I should see the Create Destination page
