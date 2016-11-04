@frequencies @frequencies-rainfallidfs-durations
Feature: frequencies/rainfallIDFs/?durations
  Acceptance tests for the query string field 'durations'.


  @frequencies-rainfallidfs-one-duration
  Scenario: one duration

    Specifying a single duration should return data for that duration only.

    (NOTE: For now, the test is not 100% robust, since we only ensure that two of the other durations are not present (15 and 30,
    i.e. the durations on each side of the target duration 20).
    Ideally, we should check all supported durations (1, 2, 3, 5, 10, 15, 20, 30, 45, 60, 90, 120,180, 360,720, 1440),
    but currently there are no consise ways of expressing such a test (in a loop, for example).)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20
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
          "duration" : 20
        }
      ]
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

    And response_notJsonSubset_200
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


  @frequencies-rainfallidfs-two-durations
  Scenario: two durations

  Specifying two durations should return a result containing those durations only.

  (see comment in Scenario one duration)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,10
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

    And response_notJsonSubset_200
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

    And response_notJsonSubset_200
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


  @frequencies-rainfallidfs-malformed-durations
  Scenario: malformed durations

  Specifying a malformed durations parameter should return a result with status code 400.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,foo,10
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Malformed query parameter: durations \\(not a comma-separated list of integers\\)"
  }
}
    """


  @frequencies-rainfallidfs-unsupported-durations
  Scenario: unsupported durations

  Specifying one or more unsupported durations should return a result with status code 400.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?durations=20,12345,10
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid query parameter: durations \\(values \\(12345\\) not in supported set \\(1, 2, 3, 5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 360, 720, 1440\\)\\)"
  }
}
    """
