Feature: sources/


  @sources @sources-supported-type
  Scenario: supported type

    Given n/a

    When request_get supported type
    """
    sources/v0.jsonld?ids=SN18700&types=SensorPlatform
    """

    Then response_jsonSubset_200 supported type
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
#  @sources @sources-unsupported-type
#  Scenario: unsupported type

#    Given n/a

#    When request_get unsupported type
#    """
#    sources/v0.jsonld?ids=SN18700&types=foobar
#    """

#    Then response_jsonSubset_400 unsupported type
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
