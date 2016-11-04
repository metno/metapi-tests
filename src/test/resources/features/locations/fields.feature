@locations @locations-fields
Feature: locations/?fields
  Acceptance tests for the query string field 'fields'.


  @locations-one-fields-value
  Scenario: one fields value

    Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one fields value ...
    """
    locations/v0.jsonld?names=Lillehammer&fields=geometry
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that fields value ...
    """
{
  "data" :
   [
     {
       "geometry" : {}
     }
   ]
}
    """

    # ... but no data for any other fields values (warning: only a subset of the other fields values are checked, so the test is not 100% robust!)

    And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "name" : ".+"
    }
  ]
}
    """

    And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "feature" : ".+"
    }
  ]
}
    """

    # could add more unexpected fields values here ... TBD


  @locations-two-fields-values
  Scenario: two fields values

  Specifying two fields should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two fields values ...
    """
    locations/v0.jsonld?names=Lillehammer&fields=geometry,name
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those fields ...
    """
{
  "data" :
   [
     {
       "geometry" : {},
       "name" : ".+"
     }
   ]
}
    """

    # ... but no data for any other fields values (warning: only a subset of the other fields values are checked, so the test is not 100% robust!)

    And response_notJsonSubset_200
    """
{
  "data" :
  [
    {
      "feature" : ".+"
    }
  ]
}
    """

    # could add more unexpected fields values here ... TBD


  @locations-unsupported-fields-value
  Scenario: unsupported fields value

  Specifying an unsupported fields value should result in 400/BadRequest

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?names=Lillehammer&fields=foobar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid fields in the query parameter: foobar"
  }
}
    """
