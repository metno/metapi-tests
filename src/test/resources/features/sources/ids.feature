@sources @sources-ids
Feature: sources-ids
  # Acceptance tests for the query string field 'ids'.


  @sources-one-id
  Scenario: sources-one-id

    # Specifying a single source ID should return data for that ID only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one source ...
    """
    sources/v0.jsonld?ids=SN18700
    """

    Then response_jsonSubset_200
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

    And response_notJsonSubset_200
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


  @sources-two-ids
  Scenario: sources-two-ids

    # Specifying two source IDs should return data for those IDs only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two sources ...
    """
    sources/v0.jsonld?ids=SN18700,SN18701
    """

    Then response_jsonSubset_200
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

    And response_jsonSubset_200
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

    And response_notJsonSubset_200
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


  @sources-invalid-source
  Scenario: sources-invalid-source

    # Specifying an invalid station source should return status=400

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?ids=foobar
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid station source name: .+"
   }
}
    """


  @sources-non-existent-source
  Scenario: sources-non-existent-source

    # Specifying a non-existent source should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?ids=SN123456789
    """

    Then response_jsonSubset_404
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
