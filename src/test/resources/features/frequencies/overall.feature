@frequencies @frequencies-rainfallidfs-overall
Feature: frequencies-rainfallidfs-overall
  # Overall acceptance tests.


  @frequencies-rainfallidfs-empty-request
  Scenario: frequencies-rainfallidfs-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld
    """

    Then response_jsonSubset_200
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


  @frequencies-rainfallidfs-unsupported-field
  Scenario: frequencies-rainfallidfs-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: durations, fields, unit, sources, frequencies"
  }
}
    """
