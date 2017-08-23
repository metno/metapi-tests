@climatenormals @climatenormals-available-overall
Feature: climatenormals-available-overall
  # Overall acceptance tests for available/ endpoint.


  @climatenormals-available-empty-request
  Scenario: climatenormals-available-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "apiVersion" : "v0",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : ".+",
    "period" : "\\d\\d\\d\\d/\\d\\d\\d\\d"
  } ]
}
    """


  @climatenormals-available-unsupported-field
  Scenario: climatenormals-available-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: sources, elements, periods, fields"
  }
}
    """
