@records @records-municipalities
Feature: records-municipalities
  # Acceptance tests for the query string parameter 'municipalities'

  @records-municipalities-non-existing
  Scenario: records-municipalities-non-existing

    # A non-existing municipality should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?municipalities=foo
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


  @records-municipalities-existing
  Scenario: records-municipalities-existing

    # An existing municipality should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?municipalities=oslo
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
