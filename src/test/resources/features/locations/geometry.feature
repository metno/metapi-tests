Feature: locations/


  @locations @locations-unsupported-geometry
  Scenario: unsupported geometry

    Given n/a

    When request_get unsupported geometry
    """
    locations/v0.jsonld?geometry=foobar
    """

    Then response_jsonSubset_400 unsupported geometry
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
