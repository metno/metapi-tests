@frequencies @frequencies-rainfall-availablesources-overall
Feature: frequencies-rainfall-availablesources-overall
  # Overall acceptance tests.


  @frequencies-rainfall-availablesources-empty-request
  Scenario: frequencies-rainfall-availablesources-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld
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

    And response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId" : "idf_bma1km_v1",
      "validFrom" : ".+",
      "validTo" : ".+",
      "numberOfSeasons" : "\\d+"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-unsupported-field
  Scenario: frequencies-rainfall-availablesources-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: sources, types, fields"
  }
}
    """
