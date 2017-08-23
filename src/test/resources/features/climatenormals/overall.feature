@climatenormals @climatenormals-overall
Feature: climatenormals-overall
  # Overall acceptance tests for base endpoint.


  @climatenormals-empty-request
  Scenario: climatenormals-empty-request

    # An empty query string should return an error since the mandatory sources parameter is missing.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld
    """

    Then response_contains_400
    """
    Missing parameter: sources
    """


  @climatenormals-unsupported-field
  Scenario: climatenormals-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=dummy&foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: sources, elements, period"
  }
}
    """
