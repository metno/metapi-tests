@records @records-sourcenames
Feature: records-sourcenames
  # Acceptance tests for the query string parameter 'sourcenames'

  @records-sourcenames-non-existing
  Scenario: records-sourcenames-non-existing

    # A non-existing source name should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?sourcenames=foo
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "Could not find records for this combination of query parameters"
  }
}
    """


  @records-sourcenames-existing
  Scenario: records-sourcenames-existing

    # An existing source name should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?sourcenames=*blindern*
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RecordsResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "sourceName" : "Oslo - Blindern",
    "county" : ".+",
    "municipality" : ".+",
    "elementId" : ".+",
    "month" : "\\d+",
    "referenceTime" : ".+",
    "value" : "\\d+\\.\\d+"
  } ]
}
    """
