@records @records-months
Feature: records-months
  # Acceptance tests for the query string parameter 'months'

  @records-months-malformed
  Scenario: records-months-malformed

    # A malformed month should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?months=foo
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "months: syntax error: foo \\(not of the form <int> or <int1>-<int2>\\)"
  }
}
    """


  @records-months-invalid
  Scenario: records-months-invalid

    # An invalid month should return an error.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?months=13
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "months outside valid range \\[1, 12\\]"
  }
}
    """


  @records-months-existing
  Scenario: records-months-existing

    # Existing months should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    records/countyExtremes/v0.jsonld?months=3-5,8
    """

    Then response_jsonSubset_200
    """
{
  "data" : [ {
    "month" : 3
  } ]
}
    """

    And response_jsonSubset_200
    """
{
  "data" : [ {
    "month" : 4
  } ]
}
    """

    And response_jsonSubset_200
    """
{
  "data" : [ {
    "month" : 5
  } ]
}
    """

    And response_jsonSubset_200
    """
{
  "data" : [ {
    "month" : 8
  } ]
}
    """

    And response_notJsonSubset_200
    """
{
  "data" : [ {
    "month" : 7
  } ]
}
    """
