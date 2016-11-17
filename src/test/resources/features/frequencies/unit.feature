@frequencies @frequencies-rainfallidfs-unit
Feature: frequencies/rainfallIDFs/?unit
  Acceptance tests for the query string field 'unit'.

  # --- BEGIN test 1 -----------------------------------------------------------------------------------------------------
  # Requesting intensity values in litres-per-second-per-hectar (the default) must correspond correctly with
  # requesting them in millilitres-per-minute.
  #
  # WARNING: The test must be updated if the values in the database change!

  @frequencies-rainfallidfs-unit-conversion-lsh-1
  Scenario: unit conversion part 1.1: litres per second per hectar (default value)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=1&frequencies=2
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "intensity" : 291.2
        }
      ]
    }
  ]
}
    """

  @frequencies-rainfallidfs-unit-conversion-lsh-2
  Scenario: unit conversion part 1.2: litres per second per hectar (explicitly specifying unit)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=1&frequencies=2&unit=l/s*Ha
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "intensity" : 291.2
        }
      ]
    }
  ]
}
    """

  @frequencies-rainfallidfs-unit-conversion-mmm
  Scenario: unit conversion part 2: millimetres per minute

    # Expected formula:
    #   l/s*Ha = lsh = litres per second per hectar
    #   lmh = litres per minute per hectar = lsh * 60
    #   lmd = litres per minute per square decimeter = lmh / 100000
    #   mmm = millimetres per minute = lmd * 100 = lmh / 10000 = lsh * 60 / 10000 = lsh * 0.006

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=1&frequencies=2&unit=mm
    """

    Then response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "intensity" : 1.7472
        }
      ]
    }
  ]
}
    """


  #--- END test 1 -----------------------------------------------------------------------------------------------------
