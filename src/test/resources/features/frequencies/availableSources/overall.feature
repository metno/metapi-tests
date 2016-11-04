@frequencies @frequencies-rainfallidfs-availablesources-overall
Feature: frequencies/rainfallIDFs/availableSources/
  Overall acceptance tests.


  @frequencies-rainfallidfs-availablesources-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld
    """

    Then response_jsonSubset_200
    """
{
  "@context" : "https://data.met.no/schema",
  "@type" : "RainfallIDFSourcesResponse",
  "apiVersion" : "v0",
  "license" : ".+",
  "createdAt" : ".+",
  "queryTime" : ".+",
  "currentItemCount" : "\\d+",
  "itemsPerPage" : "\\d+",
  "offset" : "\\d+",
  "totalItemCount" : "\\d+",
  "currentLink" : ".+",
  "data" :
  [
    {
      "sourceId" : "SN\\d+",
      "validFrom" : ".+",
      "validTo" : ".+",
      "numberOfSeasons" : "\\d+"
    }
  ]
}
    """


  @frequencies-rainfallidfs-availablesources-unsupported-field
  Scenario: unsupported field

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: sources, fields"
  }
}
    """
