@misc
Feature: Read /tests/secureHello authenticated

  @get_secure_hello_authenticated
  Scenario: Read /tests/secureHello authenticated
    Given a valid public MET API client ID
    When I make an HTTP GET request for /tests/secureHello, passing a valid client ID
    Then I should get a response with status code = 200 and body = 'Hello to you too, securely!'
