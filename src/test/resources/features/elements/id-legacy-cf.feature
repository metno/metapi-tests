@elements @elements-id-legacy-cf
Feature: elements-id-legacy-cf
  # Acceptance tests for the query string fields 'ids', 'legacyElemCodes', and 'cfStandardNames'.

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


  @elements-non-existent-id
  Scenario: elements-non-existent-id

    # Specifying a non-existent element ID should return status=404

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
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
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
    elements/v0.jsonld?legacyElemCodes=TA
    """

    Then response_jsonSubset_200
    # ... the response should contain data for that element ...
    """
{
  "data" : [ {
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TA" ]
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
    elements/v0.jsonld?legacyElemCodes=TA,FF
    """

    Then response_jsonSubset_200
    # ... the response should contain data for those two elements ...
    """
{
  "data" : [
    {
      "legacyMetNoConvention" : {
        "elemCodes" : [ "TA" ]
      }
    },
    {
      "legacyMetNoConvention" : {
        "elemCodes" : [ "FF" ]
      }
    }
  ]
}
    """


  @elements-non-existent-legacy
  Scenario: elements-non-existent-legacy

    # Specifying a non-existent legacy element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElemCodes=foobar
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
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


  @elements-non-existent-cf
  Scenario: elements-non-existent-cf

    # Specifying a non-existent CF standard name should return status=404

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
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
   }
}
    """


  # --- combinations of element ID, legacy element code and CF standard name ------------------------------------------------------

  @elements-existent-combination-id-legacy
  Scenario: elements-existent-combination-id-legacy

    # Specifying an existent combination of element ID and legacy element code should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&legacyElemCodes=TA
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "id": "air_temperature",
      "legacyMetNoConvention": {
        "elemCodes": [
          "TA"
        ]
      }
    }
  ]
}
    """


  @elements-non-existent-combination-id-legacy
  Scenario: elements-non-existent-combination-id-legacy

    # Specifying a non-existent combination of element ID and legacy element code should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=air_temperature&legacyElemCodes=FFB
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
   }
}
    """


  @elements-existent-combination-id-cf
  Scenario: elements-existent-combination-id-cf

    # Specifying an existent combination of element ID and CF standard name should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=max(cloud_area_fraction PT24H)&cfStandardNames=cloud_area_fraction
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "id": "max\\(cloud_area_fraction PT24H\\)",
      "cfConvention": {
        "standardName": "cloud_area_fraction"
      }
    }
  ]
}
    """


  @elements-non-existent-combination-id-cf
  Scenario: elements-non-existent-combination-id-cf

    # Specifying a non-existent combination of element ID and CF standard name should return status=404

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
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
   }
}
    """


  @elements-existent-combination-legacy-cf
  Scenario: elements-existent-combination-legacy-cf

    # Specifying an existent combination of legacy element code and CF standard name should return status=200

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElemCodes=TA&cfStandardNames=air_temperature
    """

    Then response_jsonSubset_200
    """
{
  "data": [
    {
      "legacyMetNoConvention": {
        "elemCodes": [
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


  @elements-non-existent-combination-legacy-cf
  Scenario: elements-non-existent-combination-legacy-cf

    # Specifying a non-existent combination of legacy element code and CF standard name should return status=404

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElemCodes=TA&cfStandardNames=cloud_area_fraction
    """

    Then response_jsonSubset_404
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of element IDs, legacy element codes, and CF standard names",
    "help": "Specify a valid combination \\(note that leaving out one of the three components will match anything\\)"
   }
}
    """
