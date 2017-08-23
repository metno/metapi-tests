@records @records-counties
Feature: records-counties
  # Acceptance tests for the query string parameter 'counties'

  @records-counties-non-existing
  Scenario: records-counties-non-existing

    # A non-existing county should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?counties=foo
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


  @records-counties-existing
  Scenario: records-counties-existing

    # An existing county should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?counties=oslo
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RecordsResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "sourceName" : ".+",
    "county" : "Oslo",
    "municipality" : ".+",
    "elementId" : ".+",
    "month" : "\\d+",
    "referenceTime" : ".+",
    "value" : "\\d+\\.\\d+"
  } ]
}
    """
