@elements @elements-element-in-uri-path
Feature: elements/<ID>
  Acceptance tests for a single element specified in the URI path.

  @elements-element-in-uri-path-existent
  Scenario: element ID in URI path

    Specifying a single element ID in the URI path should return data for that ID only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one element ...
    """
    elements/air_temperature/v0.jsonld
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that element ...
    """
{
  "data" :
  [
    {
      "id" : "air_temperature"
    }
  ]
}
    """

    And response_notJsonSubset_200
    # ... but no data for any other element (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word )
    """
{
  "data" :
  [
    {
      "id" : "^((?!air_temperature).)*$"
    }
  ]
}
    """


  @elements-element-in-uri-path-non-existent
  Scenario: non-existent element ID in URI path

  Specifying a non-existent element ID in the URI path should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/foobar/v0.jsonld
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data elements found for id foobar"
   }
}
    """
