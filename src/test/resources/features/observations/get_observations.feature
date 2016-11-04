@observations @observations-toplevel
Feature: Get observations
  Observations should be returned if they exist.
  The sensor number is assumed to be 0, if not specified. ":all" can be used to retrieve all available sensor numbers.
  Referencetimes should return all data that fits within the time period specified (exclusive/inclusive syntax).


  @observations-get-observations-with-valid-parameters
  Scenario: Get observations with valid parameters

    Given a valid public MET API client ID

    When request_get
    # I request observations with a valid source, referencetime and elementId
    """
    observations/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature T1H)
    """

    Then response_jsonSubset_200
    # I should get a response with status code = 200 and a body in valid JSON-LD format
    """
{
  "@type" : "ObservationResponse",
  "data" :
  [
    {
      "sourceId" : "SN18700:0",
      "referenceTime" : ".+",
      "observations" :
      [
        {
          "elementId" : "max\\(air_temperature T1H\\)",
          "value" : ".+",
          "unit" : ".+",
          "performanceCategory" : ".+",
          "exposureCategory" : ".+",
          "qualityCode" : ".+"
        }
      ]
    }
  ]
}
    """


  @observations-get-observations-for-non-existent-source
  Scenario: Get observations for non-existent source

    Given a valid public MET API client ID

    When request_get
    # I request observations with a non-existent source
    """
    observations/v0.jsonld?sources=SN99999&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature T1H)
    """

    Then response_jsonSubset_404
    # I should get a response with status code = 404 and a body in valid JSON-LD format
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found"
  }
}
    """


  @observations-get-observations-for-all-sensors-on-a-station
  Scenario: Get observations for all sensors on a station

    Given a valid public MET API client ID

    When request_get
    # I request air_temperature and wind_speed observations for all of the sensor numbers of a source SN3290
    """
    observations/v0.jsonld?sources=SN3290:all&referencetime=2013-08-01T00:00:00.000Z/2013-09-01T00:00:00.000Z&elements=wind_speed,air_temperature
    """

    Then response_jsonSubset_200
    # get sensors 0 and 1
    """
{
  "data" : [ {
    "sourceId": "SN3290:[0|1]"
  } ]
}
    """


  @observations-get-observations-for-sensor-1-on-a-station
  Scenario: Get observations for sensor 1 on a station

    Given a valid public MET API client ID

    When request_get
    # I request air_temperature and wind_speed observations for sensor number 1 of a source SN3290
    """
    observations/v0.jsonld?sources=SN3290:1&referencetime=2013-08-01T00:00:00.000Z/2013-09-01T00:00:00.000Z&elements=wind_speed,air_temperature
    """

    Then response_jsonSubset_200
    # get sensor 1
    """
{
  "data" : [ {
    "sourceId" : "SN3290:1"
  } ]
}
    """


  @observations-get-observations-for-non-existent-referencetime
  Scenario: Get observations for non-existent referencetime

    Given a valid public MET API client ID

    When request_get
    # I request observations for a non-existing referencetime period
    """
    observations/v0.jsonld?sources=SN18700&referencetime=1990-07-01T00:00:00/1990-09-01T00:00:00&elements=max(air_temperature T1H)
    """

    Then response_jsonSubset_404
    # I should get a response with status code = 404 and a body in valid JSON-LD format
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found"
  }
}
    """


  @observations-get-observations-for-a-referencetime-period-inside
  Scenario: Get observations for a referencetime period (inside)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime inside the period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-03-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 1440
}
    """


  @observations-get-observations-for-a-referencetime-period-overlap-lower
  Scenario: Get observations for a referencetime period (overlap lower)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime overlapping the lower bound of a period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=1992-11-01T00:00:00.000Z/1993-01-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_200
    # get data only for the time period that overlaps
    """
{
  "totalItemCount": 657
}
    """


  @observations-get-observations-for-a-referencetime-period-overlap-upper
  Scenario: Get observations for a referencetime period (overlap upper)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime overlapping the upper bound of a period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=2006-03-01T00:00:00.000Z/2006-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_200
    # get data only for the time period that overlaps
    """
{
  "totalItemCount": 775
}
    """


  @observations-get-observations-for-a-referencetime-period-overlap-both
  Scenario: Get observations for a referencetime period (overlap both)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime overlapping both bounds of a period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=2006-03-20T00:00:00.000Z/2007-07-30T00:00:00.000Z&elements=surface_temperature
    """

    Then response_jsonSubset_200
    # get data only for the time period that overlaps
    """
{
  "totalItemCount": 5588
}
    """


  @observations-get-observations-for-a-referencetime-period-exact
  Scenario: Get observations for a referencetime period (exact)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime exactly equal to the bounds of a period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=2006-04-20T00:00:00.000Z/2007-06-30T00:00:00.000Z&elements=surface_temperature
    """

    Then response_jsonSubset_200
    # get only data for the time period that overlaps
    """
{
  "totalItemCount": 5588
}
    """


  @observations-get-observations-for-a-referencetime-period-before
  Scenario: Get observations for a referencetime period (before)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime before the period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=1992-03-01T00:00:00.000Z/1992-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_404
    # I should get a response with status code = 404 and a body in valid JSON-LD format
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found"
  }
}
    """


  @observations-get-observations-for-a-referencetime-period-after
  Scenario: Get observations for a referencetime period (after)

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime after the period of a time series
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=2007-03-01T00:00:00.000Z/2007-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_404
    # I should get a response with status code = 404 and a body in valid JSON-LD format
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found"
  }
}
    """


  @observations-get-observations-for-a-referencetime-period-using-correct-inclusive-exclusive-syntax
  Scenario: Get observations for a referencetime period using correct inclusive-exclusive syntax

    Given a valid public MET API client ID

    When request_get
    # I request observations with a referencetime period where the startvalue and endvalue both match with observations
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-01-02T00:00:00.000Z&elements=mean(air_temperature%20T1H)
    """

    Then response_jsonSubset_200
    # get a response where the observation on the start is included, but the observation at the end is not
    """
{
  "totalItemCount": 24,
  "data" : [ {
    "referenceTime": "1996-01-01T..:00:00.000Z"
  } ]
}
    """


  @observations-get-observations-for-non-existent-elements
  Scenario: Get observations for non-existent elements

    Given a valid public MET API client ID

    When request_get
    # I request observations with a non-existing elementId
    """
    observations/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=weird_snow_depth_precipitation
    """

    Then response_jsonSubset_404
    # I should get a response with status code = 404 and a body in valid JSON-LD format
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found"
  }
}
    """


  @observations-get-observations-for-multiple-elements
  Scenario: Get observations for multiple elements

    Given a valid public MET API client ID

    When request_get
    # I request observations with multiple elementIds
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=1961-11-01T00:00:00.000Z/1962-02-01T00:00:00Z&elements=high_type_cloud,%20low_type_cloud
    """

    Then response_jsonSubset_200
    # get data for all elements
    """
{
  "totalItemCount": 46
}
    """

# TODO 2016-10-17:Need to test for performance category selection, but there are currently no values in the db with perfcat <> A
# TODO 2016-10-17:Need to test for exposure category selection, but there are currently no values in the db with expcat <> 1
