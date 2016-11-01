Feature: frequencies/rainfallIDFs/


  @frequencies @frequencies-rainfallidfs-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given n/a

    When request_get empty request
    """
    frequencies/rainfallIDFs/v0.jsonld
    """

    Then response_jsonSubset_200 empty request
    """
{
  "@context" : "https://data.met.no/schema",
  "@type" : "RainfallIDFResponse",
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
      "operatingPeriods" : [ ".+" ],
      "numberOfSeasons" : "\\d+",
      "unit" : "l/s\\*Ha",
      "values" :
      [
        {
          "intensity" : "\\d+.\\d+",
          "duration" : "\\d+",
          "frequency" : "\\d+"
        }
      ]
    }
  ]
}
    """
