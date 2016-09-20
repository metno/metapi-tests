Feature: Basic tests for frequencies module


  @frequencies @frequencies-one-duration
  Scenario: one duration

    Specifying a single duration should return a result containing that duration only.

    (NOTE: For now, the test is not 100% robust, since we only ensure that two of the other durations are not present (15 and 30,
    i.e. the durations on each side of the target duration 20).
    Ideally, we should check all supported durations (1, 2, 3, 5, 10, 15, 20, 30, 45, 60, 90, 120,180, 360,720, 1440),
    but currently there are no consise ways of expressing such a test (in a loop, for example).)

    Given n/a

    When request_get one duration
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20
    """

    Then response_jsonSubset_200 one duration
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 20
        }
      ]
    }
  ]
}
    """

    And response_notJsonSubset_200 one duration
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 15
        }
      ]
    }
  ]
}
    """

    And response_notJsonSubset_200 one duration
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 30
        }
      ]
    }
  ]
}
    """

  @frequencies @frequencies-two-durations
  Scenario: two durations

  Specifying two durations should return a result containing those durations only.

  (see comment in Scenario one duration)

    Given n/a

    When request_get two durations
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,10
    """

    Then response_jsonSubset_200 two durations
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 10
        },
        {
          "duration" : 20
        }
      ]
    }
  ]
}
    """

    And response_notJsonSubset_200 two durations
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 15
        }
      ]
    }
  ]
}
    """

    And response_notJsonSubset_200 two durations
    """
{
  "data" :
  [
    {
      "values" :
      [
        {
          "duration" : 30
        }
      ]
    }
  ]
}
    """


  @frequencies @frequencies-malformed-durations
  Scenario: malformed durations

  Specifying a malformed durations parameter should return a result with status code 400.

    Given n/a

    When request_get malformed durations
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,foo,10
    """

    Then response_statusOnly_400 malformed durations
    """
    n/a
    """


  @frequencies @frequencies-unsupported-durations
  Scenario: unsupported durations

  Specifying one or more unsupported durations should return a result with status code 400.

    Given n/a

    When request_get undupported durations
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,12345,10
    """

    Then response_statusOnly_400 unsupported durations
    """
    n/a
    """
