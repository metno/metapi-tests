@records @records-sources
Feature: records-sources
  # Acceptance tests for the query string parameter 'sources'

  @records-sources-non-existing
  Scenario: records-sources-non-existing

    # A non-existing source should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?sources=foo
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


  @records-sources-existing
  Scenario: records-sources-existing

    # An existing source should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?sources=SN18700
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RecordsResponse",
  "data" : [ {
    "sourceId" : "SN18700",
    "sourceName" : ".+",
    "county" : ".+",
    "municipality" : ".+",
    "elementId" : ".+",
    "month" : "\\d+",
    "referenceTime" : ".+",
    "value" : "\\d+\\.\\d+"
  } ]
}
    """
