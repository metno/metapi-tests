Feature: sources/


# TBD: Add tests for supported validtime as well!


# Uncomment the following test once we have implemented T2890
#  @sources @sources-unsupported-validtime
#  Scenario: unsupported validtime

#    Given n/a

#    When request_get unsupported validtime
#    """
#    sources/v0.jsonld?validtime=foobar
#    """

#    Then response_jsonSubset_400 unsupported validtime
#    """
#{
#  "@type" : "ErrorResponse",
#  "error" : {
#    "code" : 404,
#    "message" : "Bad Request",
#    "reason" : "Unsupported validtime value: .+"
#   }
#}
#    """
