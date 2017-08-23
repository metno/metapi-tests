@climatenormals @climatenormals-available-periods
Feature: climatenormals-available-periods
  # Acceptance tests for the query string parameter 'periods' in the available/ endpoint.


  @climatenormals-available-periods-malformed
  Scenario: climatenormals-available-periods-malformed

    # A malformed period should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?periods=foo
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

  @climatenormals-available-periods-non-existing
  Scenario: climatenormals-available-periods-non-existing

    # A non-existing period should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?periods=1000/1001
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


  @climatenormals-available-periods-existing
  Scenario: climatenormals-available-periods-existing

    # An existing period should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?periods=1931/1960
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : ".+",
    "period" : "1931/1960"
  } ]
}
    """

    And response_notJsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : ".+",
    "period" : "1961/1990"
  } ]
}
    """


  @climatenormals-available-periods-existing-multiple
  Scenario: climatenormals-available-periods-existing-multiple

    # Multiple existing periods should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?periods=1931/1960,1961/1990
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : ".+",
    "period" : "1931/1960"
  } ]
}
    """

    And response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "elementId" : ".+",
    "period" : "1961/1990"
  } ]
}
    """
