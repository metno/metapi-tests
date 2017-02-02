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
