Feature: Get single element

  @elements @get_single_element
  Scenario: Get single element
    Given a valid public MET API client ID
    When I make an HTTP GET request for /elements/air_temperature/v0.jsonld?lang=en-US
    Then I should get a response with status code = 200 and a body in valid JSON-LD format
