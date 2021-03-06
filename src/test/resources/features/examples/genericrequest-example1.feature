@genericrequest-example1
Feature: genericrequest-example1

  # Generic HTTP request/response testing - example 1

  @genericrequest-example1-scenario1
  Scenario: genericrequest-example1-scenario1

    Given a valid public MET API client ID

    When request_get
    # request test #1
    """
    elements/v0.jsonld?lang=en-US&oldElemCodes=TAN
    """

    Then response_jsonSubset_200
    # response test #1
    """
{
  "@context" : "https://data.met.no/schema",
  "@type" : "ElementResponse",
  "apiVersion" : "v\\d+",
  "license" : "https://creativecommons.org/licenses/by/3.0/no/",
  "offset" : 0,
  "data" : [ {
    "id" : "min\\(air_temperature 1M\\)"
  } ]
}
    """
