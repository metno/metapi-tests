@locations @locations-names
Feature: locations-names
  # Acceptance tests for the query string field 'names'.


  @locations-one-name
  Scenario: locations-one-name

    # Specifying one location name should return data for that name only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one location name ...
    """
    locations/v0.jsonld?names=Lillehammer
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that name ...
    """
{
  "data" :
  [
    {
      "name" : "Lillehammer"
    }
  ]
}
    """

    And response_notJsonSubset_200
    # ... but no data for any other name (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word )
    """
{
  "data" :
  [
    {
      "id" : "^((?!Lillehammer).)*$"
    }
  ]
}
    """


  @locations-two-names
  Scenario: locations-two-names

    # Specifying two location names should return data for those names only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two location names ...
    """
    locations/v0.jsonld?names=Lillehammer,Hamar
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those names ...
    """
{
  "data" :
  [
    {
      "name" : "Lillehammer"
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
      "name" : "Hamar"
    }
  ]
}
    """

    And response_notJsonSubset_200
    # ... but no data for any other name than those two (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word#comment51775736_23583655 )
    """
{
  "data" :
  [
    {
      "id" : "^((?!Lillehammer|Hamar).)*$"
    }
  ]
}
    """


  @locations-non-existing-name
  Scenario: locations-non-existing-name

    # Specifying a non-existing location name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?names=foobar
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "Could not find any data locations for location names foobar"
   }
}
    """
