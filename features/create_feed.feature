Feature: Create a new feed
  In order to automate content from RSS feeds
  A user
  Wants to be able to add rss feeds

  Background:
    Given I am a user
    And I sign in

  Scenario: New feed create 
    Given I am on the new feed page
    When I enter my feed information
    And I submit the form to create the feed
    Then I should be on the dashboard
    And I should have the following fields stored for the feed:
      |Name      | Url                         |
      |Test Feed | http://tanyahoman.com/feed/ |

  Scenario: Edit an existing feed
    Given I have a feed I want to edit
    And I am on the dashboard
    When I change my feed's name
    And I submit the form to update the feed
    Then my feed's name should be changed

  Scenario: Delete an existing feed
    Given I have a feed I want to edit
    And I go to the dashboard
    When I delete my feed
    Then my feed is removed

  Scenario: Delete an existing feed deactives its associated stream
    Given I add a feed
    And I add a stream
    And I add my feed to my stream
    And I go to the dashboard
    When I delete my feed
    Then my feed is removed
    And the stream should not be active
