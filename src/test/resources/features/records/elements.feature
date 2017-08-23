@records @records-elements
Feature: records-elements
  # Acceptance tests for the query string parameter 'elements'

  @records-elements-non-existing
  Scenario: records-elements-non-existing

    # A non-existing element should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?elements=foo
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


  @records-elements-existing
  Scenario: records-elements-existing

    # An existing element should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?elements=max(air_temperature P1D)
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RecordsResponse",
  "data" : [ {
    "sourceId" : "SN\\d+",
    "sourceName" : ".+",
    "county" : ".+",
    "municipality" : ".+",
    "elementId" : "max\\(air_temperature P1D\\)",
    "month" : "\\d+",
    "referenceTime" : ".+",
    "value" : "\\d+\\.\\d+"
  } ]
}
    """
