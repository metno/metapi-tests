@frequencies @frequencies-rainfall-fields
Feature: frequencies-rainfall-fields
  # Acceptance tests for the query string field 'fields'.


  @frequencies-rainfall-one-fields-value
  Scenario: frequencies-rainfall-one-fields-value

    # Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?fields=unit
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "unit" : ".+"
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
      "operatingPeriods" : [ ".+" ]
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


  @frequencies-rainfall-multiple-fields-values-2
  Scenario: frequencies-rainfall-multiple-fields-values-2

    # Specifying two fields values should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?fields=unit,operatingPeriods
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "unit" : ".+",
      "operatingPeriods" : [ ".+" ]
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


  @frequencies-rainfall-multiple-fields-values-all
  Scenario: frequencies-rainfall-multiple-fields-values-all

    # Specifying all fields values should return data for those fields values.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?fields=unit,operatingPeriods,numberOfSeasons
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "unit" : ".+",
      "operatingPeriods" : [ ".+" ],
      "numberOfSeasons" : ".+"
    }
  ]
}
    """


  @frequencies-rainfall-multiple-fields-values-all-permuted
  Scenario: frequencies-rainfall-multiple-fields-values-all-permuted

    # Specifying all fields values in a different order should still return data for those fields values.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?fields=operatingPeriods,unit,numberOfSeasons
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "unit" : ".+",
      "numberOfSeasons" : ".+",
      "operatingPeriods" : [ ".+" ]
    }
  ]
}
    """
