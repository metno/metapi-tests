Feature: sources/


  @sources @sources-one-id
  Scenario: one source ID

    Specifying a source ID should return data for that ID only.

    Given n/a

    When request_get one id
    # when we ask for data for one source ...
    """
    sources/v0.jsonld?ids=SN18700
    """

    Then response_jsonSubset_200 one id
    # ... the response should contain data for that source ...
    """
{
  "data" :
  [
    {
      "id" : "SN18700"
    }
  ]
}
    """

    And response_notJsonSubset_200 one id
    # ... but no data for any other source (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word )
    """
{
  "data" :
  [
    {
      "id" : "^((?!SN18700).)*$"
    }
  ]
}
    """


  @sources @sources-two-ids
  Scenario: two source IDs

  Specifying two source IDs should return data for those IDs only.

    Given n/a

    When request_get two ids
    # when we ask for data for two sources ...
    """
    sources/v0.jsonld?ids=SN18700,SN18701
    """

    Then response_jsonSubset_200 two ids
    # ... the response should contain data for those two sources ...
    """
{
  "data" :
  [
    {
      "id" : "SN18700"
    }
  ]
}
    """

    And response_jsonSubset_200 two ids
    """
{
  "data" :
  [
    {
      "id" : "SN18701"
    }
  ]
}
    """

    And response_notJsonSubset_200 one id
    # ... but no data for any other source than those two (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word#comment51775736_23583655 )
    """
{
  "data" :
  [
    {
      "id" : "^((?!SN18700|SN18701).)*$"
    }
  ]
}
    """


  @sources @sources-invalid-source
  Scenario: invalid source

  Specifying an invalid source should return status=400

    Given n/a

    When request_get invalid source
    """
    sources/v0.jsonld?ids=foobar
    """

    Then response_jsonSubset_400 invalid source
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid source name: .+"
   }
}
    """

  @sources @sources-non-existent-source
  Scenario: invalid source

  Specifying a non-existent source should return status=404

    Given n/a

    When request_get non-existent source
    """
    sources/v0.jsonld?ids=SN123456789
    """

    Then response_jsonSubset_404 non-existent source
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for any of the source ids"
   }
}
    """
