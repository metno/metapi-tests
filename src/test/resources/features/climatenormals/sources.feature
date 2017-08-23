@climatenormals @climatenormals-sources
Feature: climatenormals-sources
  # Acceptance tests for the query string parameter 'sources'


  @climatenormals-sources-malformed
  Scenario: climatenormals-sources-malformed

    # A malformed source should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=foo
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


  @climatenormals-sources-non-existing
  Scenario: climatenormals-sources-non-existing

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


  @climatenormals-sources-existing
  Scenario: climatenormals-sources-existing

    # An existing source should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    climatenormals/v0.jsonld?sources=SN18700
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ClimateNormalsResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "elementId" : ".+",
    "period" : "\\d\\d\\d\\d/\\d\\d\\d\\d"
  } ]
}
    """
