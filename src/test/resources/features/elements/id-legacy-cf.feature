@elements @elements-id-legacy-cf
Feature: elements-id-legacy-cf
  # Acceptance tests for the query string fields 'ids', 'legacyElementCodes', and 'cfStandardNames'.

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


  # --- legacy element code ------------------------------------------------------

  @elements-one-legacy
  Scenario: elements-one-legacy

    # Specifying a single legacy element code should return data for that code.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for one element ...
    """
    elements/v0.jsonld?legacyElementCodes=TA
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that element ...
    """
{
  "data" : [ {
    "legacyConvention" : {
      "elementCodes" : [ "TA" ]
    }
  } ]
}
    """


  @elements-two-legacies
  Scenario: elements-two-legacies

    # Specifying two legacy element codes should return data for those codes.

    Given a valid public MET API client ID

    When request_get
    # when we ask for data for two elements ...
    """
    elements/v0.jsonld?legacyElementCodes=TA,FF
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those two elements ...
    """
{
  "data" : [
    {
      "legacyConvention" : {
        "elementCodes" : [ "TA" ]
      }
    },
    {
      "legacyConvention" : {
        "elementCodes" : [ "FF" ]
      }
    }
  ]
}
    """


  @elements-non-existing-legacy
  Scenario: elements-non-existing-legacy

    # Specifying a non-existing legacy element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElementCodes=foobar
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


  # --- combinations of element ID, legacy element code and CF standard name ------------------------------------------------------

  @elements-existing-combination-id-legacy
  Scenario: elements-existing-combination-id-legacy

    # Specifying an existing combination of element ID and legacy element code should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&legacyElementCodes=TA
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "id": "air_temperature",
      "legacyConvention": {
        "elementCodes": [
          "TA"
        ]
      }
    }
  ]
}
    """


  @elements-non-existing-combination-id-legacy
  Scenario: elements-non-existing-combination-id-legacy

    # Specifying a non-existing combination of element ID and legacy element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&legacyElementCodes=FFB
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


  @elements-existing-combination-legacy-cf
  Scenario: elements-existing-combination-legacy-cf

    # Specifying an existing combination of legacy element code and CF standard name should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElementCodes=TA&cfStandardNames=air_temperature
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "legacyConvention": {
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


  @elements-non-existing-combination-legacy-cf
  Scenario: elements-non-existing-combination-legacy-cf

    # Specifying a non-existing combination of legacy element code and CF standard name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElementCodes=TA&cfStandardNames=cloud_area_fraction
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
