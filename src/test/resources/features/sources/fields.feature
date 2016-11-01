Feature: sources/


  @sources @sources-one-field
  Scenario: one field

    Specifying one field should return data for that field only.

    Given n/a

    When request_get one field
    # when we ask for data for one field ...
    """
    sources/v0.jsonld?ids=SN18700&fields=geometry
    """

    Then response_jsonSubset_200 one field
    # ... the response should contain data for that field ...
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

    # ... but no data for any other fields (warning: only a subset of the other fields are checked, so the test is not 100% robust!)

    And response_notJsonSubset_200 one field
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

    And response_notJsonSubset_200 one field
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

    # could add more unexpected fields here ... TBD


  @sources @sources-two-fields
  Scenario: two fields

  Specifying two fields should return data for those fields only.

    Given n/a

    When request_get two fields
    # when we ask for data for two fields ...
    """
    sources/v0.jsonld?ids=SN18700&fields=geometry,id
    """

    Then response_jsonSubset_200 two fields
    # ... the response should contain data for those fields ...
    """
{
  "data" :
   [
     {
       "geometry" : {},
       "id" : ".+"
     }
   ]
}
    """

    # ... but no data for any other fields (warning: only a subset of the other fields are checked, so the test is not 100% robust!)

    And response_notJsonSubset_200 two fields
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

    # could add more unexpected fields here ... TBD


  @sources @sources-unsupported-field
  Scenario: unsupported field

  Specifying an unsupported field should result in 400/BadRequest

    Given n/a

    When request_get unsupported field
    """
    sources/v0.jsonld?ids=SN18700&fields=foobar
    """

    Then response_jsonSubset_400 unsupported field
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid fields in the query parameter: foobar"
  }
}
    """
