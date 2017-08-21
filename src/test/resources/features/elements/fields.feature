@elements @elements-fields
Feature: elements-fields
  # Acceptance tests for the query string field 'fields'.


  @elements-one-fields-value
  Scenario: elements-one-fields-value

    # Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one fields value ...
    """
    elements/v0.jsonld?ids=air_temperature&fields=unit
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that fields value ...
    """
{
  "data" :
   [
     {
       "unit" : ".+"
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
      "id" : ".+"
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
      "name" : ".+"
    }
  ]
}
    """

    # could add more unexpected fields values here ... TBD


  @elements-two-fields-values
  Scenario: elements-two-fields-values

    # Specifying two fields values should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two fields values ...
    """
    elements/v0.jsonld?ids=air_temperature&fields=unit,id
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those fields values ...
    """
{
  "data" :
   [
     {
       "unit" : ".+",
       "id" : ".+"
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

    # could add more unexpected fields here ... TBD


  @elements-unsupported-fields-value
  Scenario: elements-unsupported-fields-value

    # Specifying an unsupported fields value should result in 400/BadRequest

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&fields=foobar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field: foobar"
  }
}
    """
