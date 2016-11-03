Feature: locations/


  @locations @locations-one-name
  Scenario: one location name

    Specifying one location name should return data for that name only.

    Given n/a

    When request_get one name
    # when we ask for data for one location name ...
    """
    locations/v0.jsonld?names=Lillehammer
    """

    Then response_jsonSubset_200 one name
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

    And response_notJsonSubset_200 one name
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


  @locations @locations-two-names
  Scenario: two location names

  Specifying two location names should return data for those names only.

    Given n/a

    When request_get two names
    # when we ask for data for two location names ...
    """
    locations/v0.jsonld?names=Lillehammer,Hamar
    """

    Then response_jsonSubset_200 two names
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

    And response_jsonSubset_200 two names
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

    And response_notJsonSubset_200 two names
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


  @locations @locations-non-existent-name
  Scenario: non-existent name

  Specifying a non-existent location name should return status=404

    Given n/a

    When request_get non-existent name
    """
    locations/v0.jsonld?names=foobar
    """

    Then response_jsonSubset_404 non-existent name
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
