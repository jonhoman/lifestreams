Feature: Create a new feed
  In order to automate content from RSS feeds
  A user
  Wants to be able to add rss feeds

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: New feed create 
    Given I am on the new feed page
    When I fill in "Feed Name" with "Test Feed"
    And I fill in "Feed URL" with "http://example.org/rss"
    And I press "Create Feed"
    Then I should be on the user root page
    And I should have the following fields stored for the feed:
      |Name      | Url                    |
      |Test Feed | http://example.org/rss |

  @wip
  Scenario: Edit an existing feed
    Given I am on the user root page
    And I have a feed I want to edit
    And I go to the user root page
    And show me the page
    When I follow "Jon's Feed"
    Then I should be on the edit feed page

