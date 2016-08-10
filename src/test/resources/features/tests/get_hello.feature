Feature: Get hello

  @tests @get_hello
  Scenario: Get hello
    Given n/a
    When I make an HTTP GET request for /tests/hello
    Then I should get a response with status code = 200 and body = 'Hello to you too!'
