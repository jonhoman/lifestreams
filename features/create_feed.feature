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
    And I fill in "Feed URL" with "http://tanyahoman.com/feed/"
    And I press "Create Feed"
    Then I should be on the user root page
    And I should have the following fields stored for the feed:
      |Name      | Url                         |
      |Test Feed | http://tanyahoman.com/feed/ |

  Scenario: Edit an existing feed
    Given I have a feed I want to edit
    And I am on the user root page
    When I follow "Jon's Feed"
    And I follow "Edit"
    And change the feed name to "Jon's Real Feed"
    And press "Update Feed"
    Then I should see "Jon's Real Feed"

  Scenario: Delete an existing feed
    Given I have a feed I want to edit
    And I go to the user root page
    When I follow "Delete Feed"
    Then I should not see "Jon's Feed"

  Scenario: Delete an existing feed deactives its associated stream
    Given I add a feed
    And I add a stream
    And I add my feed to my stream
    And I go to the user root page
    When I follow "Delete Feed"
    Then I should not see "Jon's Feed"
    And the stream should not be active

  Scenario: Autodiscover the feed url from a main url
    Given I am on the new feed page
    When I fill in "Feed Name" with "Test Feed"
    And I fill in "Feed URL" with "http://blog.jonhoman.com"
    And I press "Create Feed"
    Then I should be on the user root page
    And I should have the following fields stored for the feed:
      |Name      | Url                            |
      |Test Feed | http://blog.jonhoman.com/feed/ |
