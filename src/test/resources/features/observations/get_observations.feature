@observations @get_observations
Feature: Get observations
  Observations should be returned if they exist.
  The sensor number is assumed to be 0, if not specified. ":all" can be used to retrieve all available sensor numbers.
  Referencetimes should return all data that fits within the time period specified (exclusive/inclusive syntax).

  Scenario: Get observations with valid parameters
    Given A valid public MET API client id
    When I request observations with a valid source, referencetime and elementId
    Then I should get a response with status code = 200 and a body in valid JSON-LD format

  Scenario: Get observations for non-existent source
    Given A valid public MET API client id
    When I request observations with a non-existent source
    Then I should get a response with status code = 404 and a body in valid JSON-LD format

  Scenario: Get observations for all sensors on a station
    Given A valid public MET API client id
    When I request air_temperature and wind_speed observations for all of the sensor numbers of a source SN3290
    Then response_jsonSubset_200 gets sensors 0 and 1
    """
{
  "data" : [ {
    "sourceId": "SN3290:[0|1]"
  } ]
}
    """

  Scenario: Get observations for sensor 1 on a station
    Given A valid public MET API client id
    When I request air_temperature and wind_speed observations for sensor number 1 of a source SN3290
    Then response_jsonSubset_200 gets sensors 1 wind_speed
    """
{
  "data" : [ {
    "sourceId" : "SN3290:1"
  } ]
}
    """

  Scenario: Get observations for non-existent referencetime
    Given A valid public MET API client id
    When I request observations for a non-existing referencetime period
    Then I should get a response with status code = 404 and a body in valid JSON-LD format


  Scenario: Get observations for a referencetime period (inside)
    Given A valid public MET API client id
    When I request observations with a referencetime inside the period of a time series
    Then response_jsonSubset_200 gets a full set of data
    """
{
  "totalItemCount": 1440
}
    """

  Scenario: Get observations for a referencetime period (overlap lower)
    Given A valid public MET API client id
    When I request observations with a referencetime overlapping the lower bounds of a period of a time series
    Then response_jsonSubset_200 gets only data for the time period that overlaps
    """
{
  "totalItemCount": 657
}
    """

  Scenario: Get observations for a referencetime period (overlap upper)
    Given A valid public MET API client id
    When I request observations with a referencetime overlapping the upper bounds of a period of a time series
    Then response_jsonSubset_200 gets only data for the time period that overlaps
    """
{
  "totalItemCount": 775
}
    """

  Scenario: Get observations for a referencetime period (overlap both)
    Given A valid public MET API client id
    When I request observations with a referencetime overlapping both bounds of a period of a time series
    Then response_jsonSubset_200 gets only data for the time period that overlaps
    """
{
  "totalItemCount": 5588
}
    """

  Scenario: Get observations for a referencetime period (exact)
    Given A valid public MET API client id
    When I request observations with a referencetime exactly equal to the bounds of a period of a time series
    Then response_jsonSubset_200 gets only data for the time period that overlaps
    """
{
  "totalItemCount": 5588
}
    """

  Scenario: Get observations for a referencetime period (before)
    Given A valid public MET API client id
    When I request observations with a referencetime before the period of a time series
    Then I should get a response with status code = 404 and a body in valid JSON-LD format

  Scenario: Get observations for a referencetime period (after)
    Given A valid public MET API client id
    When I request observations with a referencetime after the period of a time series
    Then I should get a response with status code = 404 and a body in valid JSON-LD format

  Scenario: Get observations for a referencetime period using correct inclusive-exclusive syntax
    Given A valid public MET API client id
    When I request observations with a referencetime period where the startvalue and endvalue both match with observations
    Then response_jsonSubset_200 gets a response where the observation on the start is included, but the observation at the end is not
    """
{
  "totalItemCount": 24,
  "data" : [ {
    "referenceTime": "1996-01-01T..:00:00.000Z"
  } ]
}
    """

  Scenario: Get observations for non-existent elements
    Given A valid public MET API client id
    When I request observations with a non-existing elementId
    Then I should get a response with status code = 404 and a body in valid JSON-LD format

  Scenario: Get observations for multiple elements
    Given A valid public MET API client id
    When I request observations with multiple elementIds
    Then response_jsonSubset_200 gets data for all elements
    """
{
  "totalItemCount": 46
}
    """

# TODO 2016-10-17:Need to test for performance category selection, but there are currently no values in the db with perfcat <> A
# TODO 2016-10-17:Need to test for exposure category selection, but there are currently no values in the db with expcat <> 1
