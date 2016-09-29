Feature: frequencies/rainfallIDFs/availableSources/


  @frequencies @frequencies-rainfallidfs-availablesources-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given n/a

    When request_get empty request
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld
    """

    Then response_jsonSubset_200 empty request
    """
{
  "@context" : "https://data.met.no/schema/",
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
