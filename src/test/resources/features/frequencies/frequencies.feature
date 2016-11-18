@frequencies @frequencies-rainfallidfs-frequencies
Feature: frequencies-rainfallidfs-frequencies
  # Acceptance tests for the query string field 'frequencies'.


  @frequencies-rainfallidfs-one-frequency
  Scenario: frequencies-rainfallidfs-one-frequency

    # Specifying a single frequency should return data for that frequency only.

    # (NOTE: For now, the test is not 100% robust, since we ensure the absence of only two of the other frequencies (10 and 25,
    # i.e. the frequencies on each side of the target frequency 20).
    # Ideally, we should check all supported frequencies (2, 5, 10, 20, 25, 50, 100, 200),
    # but currently there is no consise way of expressing such a test (in a loop, for example).)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=20
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
          "frequency" : 20
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
          "frequency" : 10
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
          "frequency" : 25
        }
      ]
    }
  ]
}
    """


  @frequencies-rainfallidfs-two-frequencies
  Scenario: frequencies-rainfallidfs-two-frequencies

    # Specifying two frequencies should return data for those frequencies only.

    # (see comment in Scenario frequencies-rainfallidfs-one-frequency)

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,20
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
          "frequency" : 20
        },
        {
          "frequency" : 25
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
          "frequency" : 15
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
          "frequency" : 50
        }
      ]
    }
  ]
}
    """


  @frequencies-rainfallidfs-malformed-frequencies
  Scenario: frequencies-rainfallidfs-malformed-frequencies

    # Specifying a malformed frequencies parameter should return a result with status code 400.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,foo,20
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Malformed query parameter: frequencies \\(not a comma-separated list of integers\\)"
  }
}
    """


  @frequencies-rainfallidfs-unsupported-frequencies
  Scenario: frequencies-rainfallidfs-unsupported-frequencies

    # Specifying one or more unsupported frequencies should return a result with status code 400.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,12345,20
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid query parameter: frequencies \\(values \\(12345\\) not in supported set \\(2, 5, 10, 20, 25, 50, 100, 200\\)\\)"
  }
}
    """
