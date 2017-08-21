@observations @observations-examples @observations-examples-availabletimeseries
Feature: observations-examples-availabletimeseries

  # Metadata about available observations should be returned.
  # The sensor number is assumed to be 0, if not specified. ":all" can be used to retrieve metadata for all available sensor numbers.
  # Referencetimes should return all data that fits within the time period specified (exclusive/inclusive syntax).


  @observations-examples-get-available-observations-with-valid-parameters
  Scenario: observations-examples-get-available-observations-with-valid-parameters

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a valid source, referencetime and elementId
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # I should get a response with status code = 200 and a body in valid JSON-LD format
    """
{
  "@context" : ".+",
  "@type" : "ObservationTimeSeriesResponse",
  "apiVersion" : ".+",
  "license" : ".+",
  "createdAt" : ".+",
  "queryTime" : ".+",
  "currentItemCount" : "\\d+",
  "itemsPerPage" : "\\d+",
  "offset" : "\\d+",
  "totalItemCount" : "\\d+",
  "currentLink" : ".+",
  "data" : [
    {
      "sourceId" : "SN18700:0",
      "validFrom" : ".+",
      "timeOffset" : ".+",
      "resultTimeInterval" : ".+",
      "elementId" : "max\\(air_temperature PT1H\\)",
      "performanceCategory" : ".+",
      "exposureCategory" : ".+",
      "status" : ".+",
      "uri" : ".+"
    }
  ]
}
    """


  @observations-examples-get-available-observations-for-non-existent-source
  Scenario: observations-examples-get-available-observations-for-non-existent-source

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a non-existent source
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN99999&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature PT1H)
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


  @observations-examples-get-available-observations-for-all-sensors-on-a-station
  Scenario: observations-examples-get-available-observations-for-all-sensors-on-a-station

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries for all of the sensor numbers of a source SN3290
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN3290:all
    """

# DESIRED RESPONSE:
#    Then response_jsonSubset_200
#    # get sensors 0 and 1
#    """
#{
#  "data" : [ {
#    "sourceId": "SN3290:[0|1]"
#  } ]
#}
#    """

# TEMPORARY RESPONSE AWAITING CONSISTENCY BETWEEN ELEMENT IDS IN t_elem_map_timeseries AND elements/ ENDPOINT:
    Then response_jsonSubset_500
    """
{
  "error" : {
    "code" : 500,
    "message" : "Internal Server Error",
    "reason" : "Sensor level registered in t_elem_map_timeseries for from_direction_of_max\\(wind_speed PT1H\\), but no info at all was found for this element in the elements/ endpoint"
  }
}
    """


  @observations-examples-get-available-observations-for-sensor-1-on-a-station
  Scenario: observations-examples-get-available-observations-for-sensor-1-on-a-station

    Given a valid public MET API client ID

    When request_get
    # I request data for sensor number 1 of a source SN3290
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN3290:1
    """

    # get data for sensor 1 only ...

    Then response_jsonSubset_200
    """
{
  "data" : [ {
    "sourceId" : "SN3290:1"
  } ]
}
    """

    Then response_notJsonSubset_200
    """
{
  "data" : [ {
    "sourceId" : "SN3290:0"
  } ]
}
    """



  @observations-examples-get-available-observations-for-non-existent-referencetime
  Scenario: observations-examples-get-available-observations-for-non-existent-referencetime

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries for a non-existing referencetime period
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700&referencetime=1990-07-01T00:00:00/1990-09-01T00:00:00&elements=max(air_temperature PT1H)
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


  @observations-examples-get-available-observations-for-a-referencetime-period-inside
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-inside

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime inside the period of a time series
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-03-01T00:00:00.000Z&elements=mean(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 1,
  "data" : [ {
    "sourceId": "SN18700:0"
  } ]
}
    """


  @observations-examples-get-available-observations-for-a-referencetime-period-overlap-lower
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-overlap-lower

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime overlapping the lower bounds of a period of a time series
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=1992-11-01T00:00:00.000Z/1993-01-01T00:00:00.000Z&elements=mean(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get data only for the time period that overlaps
    """
{
  "totalItemCount": 1,
  "data" : [ {
    "sourceId": "SN18700:0"
  } ]
}
    """


  @observations-examples-get-available-observations-for-a-referencetime-period-overlap-upper
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-overlap-upper

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime overlapping the upper bounds of a period of a time series
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=2006-03-01T00:00:00.000Z/2006-05-01T00:00:00.000Z&elements=mean(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get data only for the time period that overlaps
    """
{
  "totalItemCount": 1,
  "data" : [ {
    "sourceId": "SN18700:0"
  } ]
}
    """


# ### Doesn't work any longer (as of 2017-02-21) ... TBD
#  @observations-examples-get-available-observations-for-a-referencetime-period-overlap-both
#  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-overlap-both
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I request available observation timeseries with a referencetime overlapping both bounds of a period of a time series
#    """
#    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=2006-03-20T00:00:00.000Z/2007-07-30T00:00:00.000Z&elements=surface_temperature
#    """
#
#    Then response_jsonSubset_200
#    # get data only for the time period that overlaps
#    """
#{
#  "totalItemCount": 1,
#  "data" : [ {
#    "sourceId": "SN18700:0"
#  } ]
#}
#    """


# ### Doesn't work any longer (as of 2017-02-21) ... TBD
#  @observations-examples-get-available-observations-for-a-referencetime-period-exact
#  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-exact
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I request available observation timeseries with a referencetime exactly equal to the bounds of a period of a time series
#    """
#    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=2006-04-20T00:00:00.000Z/2007-06-30T00:00:00.000Z&elements=surface_temperature
#    """
#
#    Then response_jsonSubset_200
#    # get data only for the time period that overlaps
#    """
#{
#  "totalItemCount": 1,
#  "data" : [ {
#    "sourceId": "SN18700:0"
#  } ]
#}
#    """


  @observations-examples-get-available-observations-for-a-referencetime-period-before
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-before

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime before the period of a time series
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=1992-03-01T00:00:00.000Z/1992-05-01T00:00:00.000Z&elements=mean(air_temperature PT1H)
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


  @observations-examples-get-available-observations-for-a-referencetime-period-after
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-after

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime after the period of a time series
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=2007-03-01T00:00:00.000Z/2007-05-01T00:00:00.000Z&elements=mean(air_temperature PT1H)
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


  @observations-examples-get-available-observations-for-a-referencetime-period-using-correct-inclusive-exclusive-syntax
  Scenario: observations-examples-get-available-observations-for-a-referencetime-period-using-correct-inclusive-exclusive-syntax

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a referencetime period where the startvalue and endvalue both match with observations
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-01-02T00:00:00.000Z&elements=mean(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get a response where the observation at the start is included, but the observation at the end is not
    """
{
  "totalItemCount": 1,
  "data" : [ {
    "validFrom": "1992-12-01T..:00:00.000Z"
  } ]
}
    """


  @observations-examples-get-available-observations-for-non-existent-elements
  Scenario: observations-examples-get-available-observations-for-non-existent-elements

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with a non-existing elementId
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=weird_snow_depth_precipitation
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


  @observations-examples-get-available-observations-for-multiple-elements
  Scenario: observations-examples-get-available-observations-for-multiple-elements

    Given a valid public MET API client ID

    When request_get
    # I request available observation timeseries with multiple elementIds
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN18700:0&referencetime=1961-11-01T00:00:00.000Z/1962-02-01T00:00:00Z&elements=high_type_cloud,low_type_cloud
    """

    Then response_jsonSubset_200
    # get data for all elements
    """
{
  "totalItemCount": 2,
  "data" : [ {
    "sourceId": "SN18700:0"
  } ]
}
    """

# TODO 2016-10-17:Need to test for performance category selection, but there are currently no values in the db with perfcat <> A
# TODO 2016-10-17:Need to test for exposure category selection, but there are currently no values in the db with expcat <> 1
