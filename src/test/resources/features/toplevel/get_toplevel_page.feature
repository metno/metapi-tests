@toplevel
Feature: toplevel

  @get-toplevel-page
  Scenario: get-toplevel-page

    Given a valid public MET API client ID

    When request_get
    # I make an HTTP GET request for /
    """
    """

    Then response_contains_200
    # I should get a response with status code = 200 and body containing 'The data.met.no API'
    """
    The data.met.no API
    """
