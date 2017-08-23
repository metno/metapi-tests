@climatenormals @climatenormals-available-sources
Feature: climatenormals-available-sources
  # Acceptance tests for the query string parameter 'sources' in the available/ endpoint.


  @climatenormals-available-sources-malformed
  Scenario: climatenormals-available-sources-malformed

    # A malformed source should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?sources=foo
    """

    Then response_jsonSubset_400
    """
 {
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Source misspelled or not found: foo"
  }
}
    """


  @climatenormals-available-sources-non-existing
  Scenario: climatenormals-available-sources-non-existing

    # A non-existing source should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?sources=SN00000
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


  @climatenormals-available-sources-existing
  Scenario: climatenormals-available-sources-existing

    # An existing source should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/available/v0.jsonld?sources=SN18700&elements=*air*
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsAvailableResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "elementId" : ".*air.*",
    "period" : "\\d\\d\\d\\d/\\d\\d\\d\\d"
  } ]
}
    """
