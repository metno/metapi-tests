@frequencies @frequencies-rainfall-overall
Feature: frequencies-rainfall-overall
  # Overall acceptance tests.


  @frequencies-rainfall-empty-request
  Scenario: frequencies-rainfall-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld
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


  @frequencies-rainfall-unsupported-field
  Scenario: frequencies-rainfall-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: location, durations, fields, unit, sources, frequencies"
  }
}
    """
