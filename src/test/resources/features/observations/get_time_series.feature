Feature: Get time series

  @observations @get_time_series
  Scenario: Get time series
    Given n/a
    When I make an HTTP GET request for /observations/timeSeries/v0.jsonld?sources=KN18700
    Then I should get a response with status code = 200 and a body in valid JSON-LD format
