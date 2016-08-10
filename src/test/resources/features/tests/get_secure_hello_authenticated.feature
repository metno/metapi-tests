Feature: Read /tests/secureHello authenticated

  @tests @get_secure_hello_authenticated
  Scenario: Read /tests/secureHello authenticated
    Given n/a
    When I make an HTTP GET request for /tests/secureHello, passing a valid client ID
    Then I should get a response with status code = 200 and body = 'Hello to you too, securely!'
