@sources @sources-geometry
Feature: sources/?geometry
  Acceptance tests for the query string field 'geometry'.


  @sources-unsupported-geometry
  Scenario: unsupported geometry

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?geometry=foobar
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "foobar is not a valid data.met.no MET API geometry specification"
   }
}
    """


    # TBD: Add tests for supported geometries as well!
