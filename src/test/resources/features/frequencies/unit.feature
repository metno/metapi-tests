@frequencies @frequencies-rainfallidfs-unit
Feature: frequencies-rainfallidfs-unit
  # Acceptance tests for the query string field 'unit'.

  # --- BEGIN test 1 -----------------------------------------------------------------------------------------------------
  # Requesting intensity values in litres-per-second-per-hectar (the default) must correspond correctly with
  # requesting them in millilitres-per-minute-times-duration.
  #
  # WARNING: The test must be updated if database values change!

  @frequencies-rainfallidfs-unit-conversion-lsh-1
  Scenario: frequencies-rainfallidfs-unit-conversion-lsh-1

    # unit conversion part 1.1: litres per second per hectar (default value)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=5&frequencies=2
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
          "intensity" : 187.3
        }
      ]
    }
  ]
}
    """

  @frequencies-rainfallidfs-unit-conversion-lsh-2
  Scenario: frequencies-rainfallidfs-unit-conversion-lsh-2

    # unit conversion part 1.2: litres per second per hectar (explicitly specifying unit)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=5&frequencies=2&unit=l/s*Ha
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
          "intensity" : 187.3
        }
      ]
    }
  ]
}
    """

  @frequencies-rainfallidfs-unit-conversion-mmmd
  Scenario: frequencies-rainfallidfs-unit-conversion-mmmd

    # unit conversion part 2: millimetres per minute multiplied by duration

    # Expected formula:
    #   l/s*Ha = lsh = litres per second per hectar
    #   lmh = litres per minute per hectar = lsh * 60
    #   lmd = litres per minute per square decimeter = lmh / 100000
    #   mmm = millimetres per minute = lmd * 100 = lmh / 10000 = lsh * 60 / 10000 = lsh * 0.006
    #   mmmd = mmm * duration = lsh * 0.006 * duration, i.e. 187.3 * 0.006 * 5 = 5.619 in this case

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?sources=SN18701&durations=5&frequencies=2&unit=mm
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
          "intensity" : 5.619
        }
      ]
    }
  ]
}
    """


  #--- END test 1 -----------------------------------------------------------------------------------------------------
