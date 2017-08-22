@frequencies @frequencies-rainfall-availablesources-sources
Feature: frequencies-rainfall-availablesources-sources
  # Acceptance tests for the query string field 'sources'.


  @frequencies-rainfall-availablesources-one-source
  Scenario: frequencies-rainfall-availablesources-one-source

    # Specifying a single source should return a result for that source.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?sources=SN18701
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId" : "SN18701"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-multiple-sources-part-1:2
  Scenario: frequencies-rainfall-availablesources-multiple-sources-part-1:2

    # Specifying two sources should return a result for those sources, and the result should be sorted on the source ID.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?sources=SN18701,SN18920
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId" : "SN18701"
    },
    {
      "sourceId" : "SN18920"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-multiple-sources-part-2:2
  Scenario: frequencies-rainfall-availablesources-multiple-sources-part-2:2

    # Check that the result is still sorted on source ID even if the order is changed in the query string.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?sources=SN18920,SN18701
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId" : "SN18701"
    },
    {
      "sourceId" : "SN18920"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-idf_bma1km
  Scenario: frequencies-rainfall-availablesources-idf_bma1km

# Specifying idf_bma1km should return the expected result.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?sources=idf_bma1km
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RainfallIDFSourcesResponse",
  "currentItemCount" : 1,
  "itemsPerPage" : 1,
  "offset" : 0,
  "totalItemCount" : 1,
  "data" : [ {
    "sourceId" : "idf_bma1km",
    "version" : "1",
    "validFrom" : "1957-01-01T00:00:00Z",
    "validTo" : "2016-01-01T00:00:00Z",
    "numberOfSeasons" : 59
  } ]
}
    """
