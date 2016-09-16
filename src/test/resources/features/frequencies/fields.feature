Feature: Basic tests for frequencies module


  @frequencies @frequencies-single-field
  Scenario: single field

    Specifying a single field should return a result containing that field and none of the other (specifiable) fields.

    Given n/a

    When request_get single field
    """
    frequencies/rainfallIDFs/v0.jsonld?fields=unit
    """

    Then response_jsonSubset_200 single field
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

    And response_notJsonSubset_200 single field
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

  And response_notJsonSubset_200 single field
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


  @frequencies @frequencies-multiple-fields-2
  Scenario: multiple fields 2

    Specifying two fields should return a result containing those fields and none of the other (specifiable) fields.

    Given n/a

    When request_get multiple fields 2
    """
    frequencies/rainfallIDFs/v0.jsonld?fields=unit,operatingPeriods
    """

    Then response_jsonSubset_200 multiple fields 2
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

    And response_notJsonSubset_200 multiple fields 2
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


  @frequencies @frequencies-multiple-fields-all
  Scenario: multiple fields all

    Specifying all fields should return a result containing those fields.

    Given n/a

    When request_get multiple fields all
    """
    frequencies/rainfallIDFs/v0.jsonld?fields=unit,operatingPeriods,numberOfSeasons
    """

    Then response_jsonSubset_200 multiple fields all
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


  @frequencies @frequencies-multiple-fields-all-permuted
  Scenario: multiple fields all permuted

    Specifying all fields in a different order should still return a result containing those fields.

    Given n/a

    When request_get multiple fields all permuted
    """
    frequencies/rainfallIDFs/v0.jsonld?fields=operatingPeriods,unit,numberOfSeasons
    """

    Then response_jsonSubset_200 multiple fields all permuted
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
