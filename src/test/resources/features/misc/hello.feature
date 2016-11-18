@misc @hello-tests
Feature: hello


  @hello
  Scenario: hello

    Given a valid public MET API client ID

    When I make an HTTP GET request for /tests/hello

    Then I should get a response with status code = 200 and body = 'Hello to you too!'


  @secure-hello-authenticated
  Scenario: secure-hello-authenticated

    Given a valid public MET API client ID

    When I make an HTTP GET request for /tests/secureHello, passing a valid client ID

    Then I should get a response with status code = 200 and body = 'Hello to you too, securely!'


  @secure-hello-unauthenticated
  Scenario: secure-hello-unauthenticated

    Given a valid public MET API client ID

    When I make an HTTP GET request for /tests/secureHello without passing a valid client ID

    Then I should get a response with status code = 401 and body = 'Missing authentication token!'
