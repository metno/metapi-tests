@climatenormals @climatenormals-elements
Feature: climatenormals-elements
  # Acceptance tests for the query string parameter 'elements'

  @climatenormals-elements-non-existing
  Scenario: climatenormals-elements-non-existing

    # A non-existing element should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700&elements=foo
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


  @climatenormals-elements-existing
  Scenario: climatenormals-elements-existing

    # An existing element should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700&elements=standard_deviation(mean(air_temperature P1D) P1M)
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "elementId" : "standard_deviation\\(mean\\(air_temperature P1D\\) P1M\\)",
    "period" : "\\d\\d\\d\\d/\\d\\d\\d\\d",
    "month" : "\\d+",
    "normal" : "\\d+\\.\\d+"
  } ]
}
    """
