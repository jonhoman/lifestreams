Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Background:
    Given I am a user
    And I sign in
    And I add two feeds
    And I configure two twitter accounts
    And I add an email list
    And I configure my facebook account

  Scenario: Stream created with 2 feeds, 2 twitter accounts, facebook and email
    Given I want to create a new stream
    When I fill in the stream information
    Then I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have two feeds
    And my stream should have two twitter accounts
    And my stream should have a reference to the facebook account I chose
    And my stream should have a reference to the email list I chose

  Scenario: Stream created with including categories 
    Given I want to create a new stream
    When I fill in the stream information with included categories
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       | Included Categories |
      |Test Stream| tech                |

  Scenario: Stream created without a name 
    Given I want to create a new stream
    When I leave the name blank
    Then I should see that the name cannot be blank

  Scenario: Editing a stream to have no destination 
    Given I have a stream I want to edit
    And I am on the dashboard
    When I edit my stream to have no destinations
    Then my stream shouldn't have any destinations

  Scenario: Edit a stream created with a feed and a twitter account 
    Given I have a stream I want to edit
    And I am on the dashboard
    When I edit my stream's name
    Then my stream's name should have changed

  Scenario: Delete an existing stream
    Given I have a stream I want to edit
    And I go to the dashboard
    When I delete my stream
    Then my stream is removed
