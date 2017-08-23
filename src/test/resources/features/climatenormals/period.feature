@climatenormals @climatenormals-period
Feature: climatenormals-period
  # Acceptance tests for the query string parameter 'period'

  @climatenormals-period-malformed
  Scenario: climatenormals-period-malformed

    # A malformed period should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700&period=foo
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid period",
    "help" : "Supported format: yyyy/yyyy"
  }
}    """

  @climatenormals-period-non-existing
  Scenario: climatenormals-period-non-existing

    # A non-existing period should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700&period=1000/1001
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "Could not find climate normals for this combination of query parameters"
  }
}
    """


  @climatenormals-period-existing
  Scenario: climatenormals-period-existing

    # An existing period should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700&period=1931/1960
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "elementId" : ".+",
    "period" : "1931/1960"
  } ]
}
    """

    And response_notJsonSubset_200
    """
{
  "@type" : "ClimateNormalsResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "elementId" : ".+",
    "period" : "1961/1990"
  } ]
}
    """
