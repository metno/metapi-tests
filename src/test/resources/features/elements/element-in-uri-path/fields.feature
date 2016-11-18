@elements @elements-element-in-uri-path-fields
Feature: elements-element-in-uri-path-fields
  # Acceptance tests for the query string field 'fields' for a single element specified in the URI path.


  @elements-element-in-uri-path-one-fields-value
  Scenario: elements-element-in-uri-path-one-fields-value

    # Specifying a single fields value should return data for that fields value only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one fields value ...
    """
    elements/air_temperature/v0.jsonld?fields=unit
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


  @elements-element-in-uri-path-two-fields-values
  Scenario: elements-element-in-uri-path-two-fields-values

    # Specifying two fields values should return data for those fields values only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two fields values ...
    """
    elements/air_temperature/v0.jsonld?fields=unit,id
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


  @elements-element-in-uri-path-unsupported-fields-value
  Scenario: elements-element-in-uri-path-unsupported-fields-value

    # Specifying an unsupported fields value should result in 400/BadRequest

    Given a valid public MET API client ID

    When request_get
    """
    elements/air_temperature/v0.jsonld?fields=foobar
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
