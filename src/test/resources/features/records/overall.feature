@records @records-overall
Feature: records-overall
  # Overall acceptance tests.


  @records-empty-request
  Scenario: records-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld
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
    "elementId" : ".+",
    "month" : "\\d+",
    "referenceTime" : ".+",
    "value" : "\\d+\\.\\d+"
  } ]
}
    """


  @records-unsupported-field
  Scenario: records-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: elements, municipalities, sourcenames, fields, counties, sources, months"
  }
}
    """
