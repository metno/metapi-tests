Feature: frequencies/rainfallIDFs/availableSources/


  @frequencies @frequencies-rainfallidfs-availablesources-single-source
  Scenario: single source

    Specifying a single source should return a result for that source.

    Given n/a

    When request_get single source
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?sources=SN18701
    """

      Then response_jsonSubset_200 single source
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


  @frequencies @frequencies-rainfallidfs-availablesources-multiple-sources
  Scenario: multiple sources part 1:2

    Specifying two sources should return a result for those sources, and the result should be sorted on the source ID.

    Given n/a

    When request_get multiple sources part 1:2
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?sources=SN18701,SN18920
    """

    Then response_jsonSubset_200 multiple sources part 1:2
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


  @frequencies @frequencies-rainfallidfs-availablesources-multiple-sources
  Scenario: multiple sources part 2:2

    Check that the result is still sorted on source ID even if the order is changed in the query string.

    Given n/a

    When request_get multiple sources part 2:2
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?sources=SN18920,SN18701
    """

    Then response_jsonSubset_200 multiple sources part 2:2
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
