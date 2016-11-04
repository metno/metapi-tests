@sources @sources-types
Feature: sources/?types
  Acceptance tests for the query string field 'types'.


  @sources-supported-type
  Scenario: supported type

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?ids=SN18700&types=SensorPlatform
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "SourceResponse",
  "data" : [ {
    "@type" : "SensorPlatform",
    "id" : "SN18700",
    "name" : "OSLO - BLINDERN"
  } ]
}
    """

# Uncomment the following test once we have implemented T2887
#  @sources-unsupported-type
#  Scenario: unsupported type

#    Given a valid public MET API client ID

#    When request_get
#    """
#    sources/v0.jsonld?ids=SN18700&types=foobar
#    """

#    Then response_jsonSubset_400
#    """
#{
#  "@type" : "ErrorResponse",
#  "error" : {
#    "code" : 404,
#    "message" : "Bad Request",
#    "reason" : "Unsupported types value: .+"
#   }
#}
#    """
