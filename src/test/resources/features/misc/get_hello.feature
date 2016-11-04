@misc
Feature: Get hello

  @get_hello
  Scenario: Get hello
    Given a valid public MET API client ID
    When I make an HTTP GET request for /tests/hello
    Then I should get a response with status code = 200 and body = 'Hello to you too!'
