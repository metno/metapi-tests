@sources @sources-validtime
Feature: sources-validtime
  # Acceptance tests for the query string field 'validtime'.

# TBD: Add tests for supported validtime as well!


# Uncomment the following test once we have implemented T2891
#  @sources-unsupported-validtime
#  Scenario: sources-unsupported-validtime

#    Given a valid public MET API client ID

#    When request_get
#    """
#    sources/v0.jsonld?validtime=foobar
#    """

#    Then response_jsonSubset_400
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
