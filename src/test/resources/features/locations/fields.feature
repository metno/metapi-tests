Feature: locations/


  @locations @locations-one-fields-value
  Scenario: one fields value

    Specifying one fields value should return data for that fields value only.

    Given n/a

    When request_get one fields value
    # when we ask for data for one fields value ...
    """
    locations/v0.jsonld?names=Lillehammer&fields=geometry
    """

    Then response_jsonSubset_200 one fields value
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

    And response_notJsonSubset_200 one fields value
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

    And response_notJsonSubset_200 one fields value
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


  @locations @locations-two-fields-values
  Scenario: two fields values

  Specifying two fields should return data for those fields values only.

    Given n/a

    When request_get two fields values
    # when we ask for data for two fields values ...
    """
    locations/v0.jsonld?names=Lillehammer&fields=geometry,name
    """

    Then response_jsonSubset_200 two fields values
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

    And response_notJsonSubset_200 two fields values
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


  @locations @locations-unsupported-fields-value
  Scenario: unsupported fields value

  Specifying an unsupported fields value should result in 400/BadRequest

    Given n/a

    When request_get unsupported fields value
    """
    locations/v0.jsonld?names=Lillehammer&fields=foobar
    """

    Then response_jsonSubset_400 unsupported fields value
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid fields in the query parameter: foobar"
  }
}
    """
