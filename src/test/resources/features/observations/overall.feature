@observations @observations-overall
Feature: observations-overall
  # Overall acceptance tests.


  @observations-empty-request
  Scenario: observations-empty-request

    # An empty query string should return 400/BadRequest since the mandatory query string field 'sources' is missing.

    Given a valid public MET API client ID

    When request_get
    """
    observations/v0.jsonld
    """

    Then response_contains_400
    """
Missing parameter: sources
    """


  @observations-unsupported-field
  Scenario: observations-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    observations/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=dummy&foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: elements, levels, performancecategory, exposurecategory, referencetime, fields, sources"
  }
}
    """
