Feature: Get time series

  @observations @get_time_series
  Scenario Outline: Get time series
    Given n/a
    When I make an HTTP GET request for /observations/timeSeries/v0.jsonld?sources=SN<station>
    Then I should get a response with status code = 200 and a body in valid JSON-LD format

    Examples:
      | station | comment |
      | 18700   | Blindern |
      | 41770   | Lindesnes fyr |
      | 96400   | Slettnes fyr  |
