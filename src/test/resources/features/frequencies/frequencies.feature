Feature: frequencies/rainfallIDFs/


  @frequencies @frequencies-rainfallidfs-one-frequency
  Scenario: one frequency

    Specifying a single frequency should return a result containing that frequency only.

    (NOTE: For now, the test is not 100% robust, since we ensure the absence of only two of the other frequencies (10 and 25,
    i.e. the frequencies on each side of the target frequency 20).
    Ideally, we should check all supported frequencies (2, 5, 10, 20, 25, 50, 100, 200),
    but currently there is no consise way of expressing such a test (in a loop, for example).)

    Given n/a

    When request_get one frequency
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=20
    """

    Then response_jsonSubset_200 one frequency
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

    And response_notJsonSubset_200 one frequency
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

    And response_notJsonSubset_200 one frequency
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

  @frequencies @frequencies-rainfallidfs-two-frequencies
  Scenario: two frequencies

  Specifying two frequencies should return a result containing those frequencies only.

  (see comment in Scenario one frequency)

    Given n/a

    When request_get two frequencies
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,20
    """

    Then response_jsonSubset_200 two frequencies
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

    And response_notJsonSubset_200 two frequencies
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

    And response_notJsonSubset_200 two frequencies
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


  @frequencies @frequencies-rainfallidfs-malformed-frequencies
  Scenario: malformed frequencies

  Specifying a malformed frequencies parameter should return a result with status code 400.

    Given n/a

    When request_get malformed frequencies
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,foo,20
    """

    Then response_jsonSubset_400 malformed frequencies
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Malformed query parameter: frequencies \\(not a comma-separated list of integers\\)"
  }
}
    """


  @frequencies @frequencies-rainfallidfs-unsupported-frequencies
  Scenario: unsupported frequencies

  Specifying one or more unsupported frequencies should return a result with status code 400.

    Given n/a

    When request_get unsupported frequencies
    """
    frequencies/rainfallIDFs/v0.jsonld?frequencies=25,12345,20
    """

    Then response_jsonSubset_400 unsupported frequencies
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid query parameter: frequencies \\(values \\(12345\\) not in supported set \\(2, 5, 10, 20, 25, 50, 100, 200\\)\\)"
  }
}
    """
