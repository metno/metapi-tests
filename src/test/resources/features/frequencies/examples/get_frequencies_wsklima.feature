@frequencies @frequencies-examples @frequencies-examples-wsklima
Feature: frequencies-examples-wsklima
  # Use wsKlima example queries as test cases.


  @frequencies-examples-wsklima-example1
  Scenario: frequencies-examples-wsklima-example1
    Given a valid public MET API client ID

    When request_get
    # I request IDF data for Oslo-Blindern SN18701
    """
    frequencies/rainfall/v0.jsonld?sources=SN18701
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
 {
  "@type" : "RainfallIDFResponse",
  "totalItemCount" : 1,
  "data" : [ {
    "sourceId" : "SN18701",
    "operatingPeriods" : [ "1968-01-01T00:00:00Z/1968-11-30T00:00:00Z" ],
    "numberOfSeasons" : 46,
    "unit" : "l/s\\*Ha",
    "values" : [ {
      "intensity" : "291\\.2",
      "duration" : 1,
      "frequency" : 2
    } ]
  } ]
}
   """
