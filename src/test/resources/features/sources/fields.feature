@sources @sources-fields
Feature: sources-fields
  # Acceptance tests for the query string field 'fields'.


  @sources-one-fields-value
  Scenario: sources-one-fields-value

    # Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one fields value ...
    """
    sources/v0.jsonld?ids=SN18700&fields=geometry
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that fields value and the required 'id' value ...
    """
{
  "data" :
   [
     {
       "id" : ".+",
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
      "validFrom" : ".+"
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
      "validTo" : ".+"
    }
  ]
}
    """

    # could add more unexpected fields values here ... TBD


  @sources-two-fields-values
  Scenario: sources-two-fields-values

    # Specifying two fields values should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two fields values ...
    """
    sources/v0.jsonld?ids=SN18700&fields=geometry,validFrom
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those fields values and the required 'id' value ...
    """
{
  "data" :
   [
     {
       "id" : ".+",
       "geometry" : {},
       "validFrom" : ".+"
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
      "validTo" : ".+"
    }
  ]
}
    """

    # could add more unexpected fields here ... TBD


  @sources-unsupported-fields-value
  Scenario: sources-unsupported-fields-value

    # Specifying an unsupported fields value should result in 400/BadRequest

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?ids=SN18700&fields=foobar
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
