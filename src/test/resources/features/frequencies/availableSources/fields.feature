@frequencies @frequencies-rainfall-availablesources-fields
Feature: frequencies-rainfall-availablesources-fields
  # Acceptance tests for the query string field 'fields'.


  @frequencies-rainfall-availablesources-one-fields-value
  Scenario: frequencies-rainfall-availablesources-one-fields-value

    # Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?fields=validFrom
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId": "SN\\d+",
      "validFrom" : ".+"
    }
  ]
}
    """

    And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "validTo" : ".+"
    }
  ]
}
    """

  And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "numberOfSeasons" : ".+"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-multiple-fields-values-2
  Scenario: frequencies-rainfall-availablesources-multiple-fields-values-2

    # Specifying two fields values should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?fields=validFrom,validTo
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId": "SN\\d+",
      "validFrom" : ".+",
      "validTo" : ".+"
    }
  ]
}
    """

    And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "numberOfSeasons" : ".+"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-multiple-fields-values-all
  Scenario: frequencies-rainfall-availablesources-multiple-fields-values-all

    # Specifying all fields values should return data for those fields values.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?fields=validFrom,validTo,numberOfSeasons
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId": "SN\\d+",
      "validFrom" : ".+",
      "validTo" : ".+",
      "numberOfSeasons" : "\\d+"
    }
  ]
}
    """


  @frequencies-rainfall-availablesources-multiple-fields-values-all-permuted
  Scenario: frequencies-rainfall-availablesources-multiple-fields-values-all-permuted

    Specifying all fields values in a different order should still return data for those fields values.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/availableSources/v0.jsonld?fields=validTo,numberOfSeasons,validFrom
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "sourceId": "SN\\d+",
      "validFrom" : ".+",
      "validTo" : ".+",
      "numberOfSeasons" : "\\d+"
    }
  ]
}
    """
