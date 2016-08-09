Feature: Get /tests/secureHello unauthenticated

  @get_secure_hello_unauthenticated
  Scenario: Get /tests/secureHello unauthenticated
    Given n/a
    When I make an HTTP GET request for /tests/secureHello without passing a valid client ID
    Then I should get a response with status code = 401 and body = 'Missing authentication token!'
