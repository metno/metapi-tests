Feature: frequencies/rainfallIDFs/availableSources/


  @frequencies @frequencies-rainfallidfs-availablesources-single-field
  Scenario: single field

    Specifying a single field should return a result containing that field and none of the other (specifiable) fields.

    Given n/a

    When request_get single field
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?fields=validFrom
    """

    Then response_jsonSubset_200 single field
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

    And response_notJsonSubset_200 single field
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


  @frequencies @frequencies-rainfallidfs-availablesources-multiple-fields-2
  Scenario: multiple fields 2

    Specifying two fields should return a result containing those fields and none of the other (specifiable) fields.

    Given n/a

    When request_get multiple fields 2
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?fields=validFrom,validTo
    """

    Then response_jsonSubset_200 multiple fields 2
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


  @frequencies @frequencies-rainfallidfs-availablesources-multiple-fields-all
  Scenario: multiple fields all

    Specifying all fields should return a result containing those fields.

    Given n/a

    When request_get multiple fields all
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?fields=validFrom,validTo,numberOfSeasons
    """

    Then response_jsonSubset_200 multiple fields all
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


  @frequencies @frequencies-rainfallidfs-availablesources-multiple-fields-all-permuted
  Scenario: multiple fields all permuted

    Specifying all fields in a different order should still return a result containing those fields.

    Given n/a

    When request_get multiple fields all permuted
    """
    frequencies/rainfallIDFs/availableSources/v0.jsonld?fields=validTo,numberOfSeasons,validFrom
    """

    Then response_jsonSubset_200 multiple fields all permuted
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
