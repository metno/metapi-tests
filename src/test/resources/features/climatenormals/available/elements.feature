@climatenormals @climatenormals-available-elements
Feature: climatenormals-available-elements
  # Acceptance tests for the query string parameter 'elements' in the available/ endpoint.


  @climatenormals-available-elements-non-existing
  Scenario: climatenormals-available-elements-non-existing

    # A non-existing element should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?elements=foo
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "No valid elements specified",
    "help" : "valid elements for month normals: .+"
  }
}
    """


  @climatenormals-available-elements-existing
  Scenario: climatenormals-available-elements-existing

    # An existing element should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?elements=standard_deviation(mean(air_temperature P1D) P1M)
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : "standard_deviation\\(mean\\(air_temperature P1D\\) P1M\\)",
    "period" : "\\d\\d\\d\\d/\\d\\d\\d\\d"
  } ]
}
    """
