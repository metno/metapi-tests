@elements @elements-id-old-cf
Feature: elements-id-old-cf
  # Acceptance tests for the query string fields 'ids', 'oldElementCodes', and 'cfStandardNames'.

  # --- element ID ------------------------------------------------------

  @elements-one-id
  Scenario: elements-one-id

    # Specifying a single element ID should return data for that ID only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one element ...
    """
    elements/v0.jsonld?ids=air_temperature
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


  @elements-two-ids
  Scenario: elements-two-ids

    # Specifying two element IDs should return data for those IDs only.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two elements ...
    """
    elements/v0.jsonld?ids=air_temperature,beaufort_wind_force
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those two elements ...
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

    And response_jsonSubset_200
    """
{
  "data" :
  [
    {
      "id" : "beaufort_wind_force"
    }
  ]
}
    """

    And response_notJsonSubset_200
    # ... but no data for any other element than those two (see http://stackoverflow.com/questions/406230/regular-expression-to-match-line-that-doesnt-contain-a-word#comment51775736_23583655 )
    """
{
  "data" :
  [
    {
      "id" : "^((?!air_temperature|beaufort_wind_force).)*$"
    }
  ]
}
    """


  @elements-non-existing-id
  Scenario: elements-non-existing-id

    # Specifying a non-existing element ID should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=foobar
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """


  # --- old element code ------------------------------------------------------

  @elements-one-old
  Scenario: elements-one-old

    # Specifying a single old element code should return data for that code.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one element ...
    """
    elements/v0.jsonld?oldElementCodes=TA
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that element ...
    """
{
  "data" : [ {
    "oldConvention" : {
      "elementCodes" : [ "TA" ]
    }
  } ]
}
    """


  @elements-two-legacies
  Scenario: elements-two-legacies

    # Specifying two old element codes should return data for those codes.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two elements ...
    """
    elements/v0.jsonld?oldElementCodes=TA,FF
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those two elements ...
    """
{
  "data" : [
    {
      "oldConvention" : {
        "elementCodes" : [ "TA" ]
      }
    },
    {
      "oldConvention" : {
        "elementCodes" : [ "FF" ]
      }
    }
  ]
}
    """


  @elements-non-existing-old
  Scenario: elements-non-existing-old

    # Specifying a non-existing old element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?oldElementCodes=foobar
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """


  # --- CF standard name ------------------------------------------------------

  @elements-one-cf
  Scenario: one CF standard name

    # Specifying a single CF standard name should return data for that name.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one element ...
    """
    elements/v0.jsonld?cfStandardNames=air_temperature
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that element ...
    """
{
  "data" : [ {
    "cfConvention" : {
      "standardName" : "air_temperature"
    }
  } ]
}
    """


  @elements-two-cfs
  Scenario: elements-two-cfs

    # Specifying two CF standard names should return data for those names.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two elements ...
    """
    elements/v0.jsonld?cfStandardNames=air_temperature,cloud_area_fraction
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those two elements ...
    """
{
  "data" : [
    {
      "cfConvention" : {
        "standardName" : "air_temperature"
      }
    },
    {
      "cfConvention" : {
        "standardName" : "cloud_area_fraction"
      }
    }
  ]
}
    """


  @elements-non-existing-cf
  Scenario: elements-non-existing-cf

    # Specifying a non-existing CF standard name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?cfStandardNames=foobar
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """


  # --- combinations of element ID, old element code and CF standard name ------------------------------------------------------

  @elements-existing-combination-id-old
  Scenario: elements-existing-combination-id-old

    # Specifying an existing combination of element ID and old element code should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&oldElementCodes=TA
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "id": "air_temperature",
      "oldConvention": {
        "elementCodes": [
          "TA"
        ]
      }
    }
  ]
}
    """


  @elements-non-existing-combination-id-old
  Scenario: elements-non-existing-combination-id-old

    # Specifying a non-existing combination of element ID and old element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&oldElementCodes=FFB
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """


  @elements-existing-combination-id-cf
  Scenario: elements-existing-combination-id-cf

    # Specifying an existing combination of element ID and CF standard name should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=max(cloud_area_fraction P1D)&cfStandardNames=cloud_area_fraction
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "id": "max\\(cloud_area_fraction P1D\\)",
      "cfConvention": {
        "standardName": "cloud_area_fraction"
      }
    }
  ]
}
    """


  @elements-non-existing-combination-id-cf
  Scenario: elements-non-existing-combination-id-cf

    # Specifying a non-existing combination of element ID and CF standard name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&cfStandardNames=cloud_area_fraction
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """


  @elements-existing-combination-old-cf
  Scenario: elements-existing-combination-old-cf

    # Specifying an existing combination of old element code and CF standard name should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?oldElementCodes=TA&cfStandardNames=air_temperature
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "oldConvention": {
        "elementCodes": [
          "TA"
        ]
      },
      "cfConvention": {
        "standardName": "air_temperature"
      }
    }
  ]
}
    """


  @elements-non-existing-combination-old-cf
  Scenario: elements-non-existing-combination-old-cf

    # Specifying a non-existing combination of old element code and CF standard name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?oldElementCodes=TA&cfStandardNames=cloud_area_fraction
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
   }
}
    """
