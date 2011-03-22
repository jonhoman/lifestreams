Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed
    And I configure two twitter accounts
    And I add an email list
    And I configure my facebook account

  Scenario: Stream created with a feed and a twitter account 
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I check "test" 
    And I press "Create Stream"
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I chose
    And my stream should have a reference to the twitter account I chose

  Scenario: Stream created with a feed and 2 twitter accounts
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I check "test" 
    And I check "different_handle" 
    And I press "Create Stream"
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I chose
    And my stream should have two twitter accounts

  Scenario: Stream created with a feed and an email list
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I check "example email list" 
    And I press "Create Stream"
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I chose
    And my stream should have a reference to the email list I chose

  Scenario: Stream created with a feed and a facebook account
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I check "Facebook Account" 
    And I press "Create Stream"
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I chose
    And my stream should have a reference to the facebook account I chose

  Scenario: Stream created with including categories 
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I check "test" 
    And I fill in "Only include these categories:" with "tech"
    And I press "Create Stream"
    Then I should be on the dashboard
    And I should have the following fields stored for the stream:
      |Name       | Included Categories |
      |Test Stream| tech                |
    And my stream should have a reference to the feed I chose
    And my stream should have a reference to the twitter account I chose

  Scenario: Stream created without a name 
    Given I follow "Add new Stream"
    And I check "test" 
    When I press "Create Stream"
    Then I should see "Name can't be blank"

  Scenario: Editing a stream to have no destination 
    Given I have a stream I want to edit
    And I am on the dashboard
    When I follow "example stream"
    And I follow "Edit"
    And I check "" 
    And I uncheck "test" 
    And I press "Update Stream"
    Then my stream shouldn't have twitter accounts

  Scenario: Edit a stream created with a feed and a twitter account 
    Given I have a stream I want to edit
    And I am on the dashboard
    When I follow "example stream"
    And I follow "Edit"
    And I change the stream name to "Real Stream"
    And I press "Update Stream"
    Then I should see "Real Stream"

  Scenario: Delete an existing stream
    Given I have a stream I want to edit
    And I go to the dashboard
    When I follow "Delete Stream"
    Then I should not see "Jon's Feed"
