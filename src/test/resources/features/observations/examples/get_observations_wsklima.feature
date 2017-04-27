@observations @observations-examples @observations-examples-wsklima
Feature: observations-examples @observations-examples-wsklima
  # Use wsKlima example queries as test cases.


# This test is temporarily disabled since it started to fail (2017-04-27) due to unexpected 404 Not Found. Need to investigate this ... TBD.
#
#  @observations-examples-wsklima-example0
#  Scenario: observations-examples-wsklima-example0
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I request observations for august and september only from 2004-2006
#    """
#    observations/v0.jsonld?sources=SN18700,SN50540&referencetime=R3/2004-08-01T00:00/2004-10-01T00:00/P1Y&elements=max(air_temperature P1M),min(air_temperature P1M),sum(precipitation_amount P1M)
#    """
#
#    Then response_jsonSubset_200
#    # get a full set of data
#    """
#{
#  "totalItemCount": 12,
#  "data" : [ {
#    "referenceTime": "200[4|5|6]-0[8|9]-01T00:00:00.000Z"
#  } ]
#}
#    """
# I think the item count here may be incorrect (duplicate element?). Should be double-checked.


# This test is temporarily disabled since it started to fail (2017-04-27) due to unexpected 404 Not Found. Need to investigate this ... TBD.
#
#  @observations-examples-wsklima-example1
#  Scenario: observations-examples-wsklima-example1
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I retrieve monthly means for all months from July 2005 to July 2006
#    """
#    observations/v0.jsonld?sources=SN18700,SN50540&referencetime=2005-07-01T00:00/2006-07-01T00:00&elements=max(air_temperature P1M),min(air_temperature P1M),sum(precipitation_amount P1M)
#    """
#
#    Then response_jsonSubset_200
#    # get a full set of data
#    """
#{
#  "totalItemCount": 24,
#  "data" : [ {
#    "referenceTime": "200[5|6]-..-01T00:00:00.000Z"
#  } ]
#}
#    """


  @observations-examples-wsklima-example2
  Scenario: observations-examples-wsklima-example2

    Given a valid public MET API client ID

    When request_get
    # I retrieve all 00, 06, 12, 18 observations for January 2006
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=R186/2006-01-01T00:00:00.000Z/2006-01-01T00:00:00.000Z/PT6H&elements=mean(air_temperature PT1H),max(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 186,
  "data" : [ {
    "referenceTime": "2006-01-..T00:00:00.000Z"
  } ]
}
    """


# This test is temporarily disabled since it started to fail (2017-04-27) due to unexpected 404 Not Found. Need to investigate this ... TBD.
#
#  @observations-examples-wsklima-example3
#  Scenario: observations-examples-wsklima-example3
#
#    # Note: not the same as normals - will need revision
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I retrieve monthly means over a 30 year period
#    """
#    observations/v0.jsonld?sources=SN18700,SN50540&referencetime=1961-01-01T00:00/P30Y&elements=mean(air_temperature P1M)
#    """
#
#    Then response_jsonSubset_200
#    # get a full set of data
#    """
#{
#  "totalItemCount": 720,
#  "data" : [ {
#    "referenceTime": "19[6|7|8|9].-..-01T00:00:00.000Z"
#  } ]
#}
#    """


#  @observations-examples-wsklima-example4
#  Scenario: observations-examples-wsklima-example4
#
#    # Note: not the same as normals - will need revision
#
#    Given a valid public MET API client ID
#
#    When request_get
#    # I retrieve daily means over a 30 year period
#    """
#    observations/v0.jsonld?sources=SN18700,SN50540&referencetime=1961-01-01T00:00/P30Y&elements=mean(air_temperature T24H)
#    """
#
#    Then response_jsonSubset_200
#    # get a full set of data
#    """
#{
#  "totalItemCount": 720,
#  "data" : [ {
#    "referenceTime": "19[6|7|8|9].-..-01T00:00:00.000Z"
#  } ]
#}
#    """


  @observations-examples-wsklima-example8.1
  Scenario: observations-examples-wsklima-example8.1

    Given a valid public MET API client ID

    When request_get
    # I retrieve twice daily min and max temperatures for Gardermoen
    """
    observations/v0.jsonld?sources=SN4780:0&referencetime=2008-09-01T00:00:00.000Z/2008-10-01T00:00:00.000Z&elements=min(air_temperature PT12H),max(air_temperature PT12H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 60,
  "data" : [ {
    "referenceTime": "2008-09-..T..:00:00.000Z"
  } ]
}
    """


  @observations-examples-wsklima-example8.2
  Scenario: observations-examples-wsklima-example8.2

    Given a valid public MET API client ID

    When request_get
    # I retrieve 0600 min and max temperatures for Gardermoen
    """
    observations/v0.jsonld?sources=SN4780:0&referencetime=R30/2008-09-01T06:00:00.000Z/2008-09-01T06:00:00.000Z/PT24H&elements=min(air_temperature PT12H),max(air_temperature PT12H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 30,
  "data" : [ {
    "referenceTime": "2008-09-..T06:00:00.000Z"
  } ]
}
    """


  @observations-examples-wsklima-example9
  Scenario: observations-examples-wsklima-example9

    Given a valid public MET API client ID

    When request_get
    # I retrieve 1200 min and max temperatures for Ekofisk
    """
    observations/v0.jsonld?sources=SN76920&referencetime=R30/2008-09-01T12:00/2008-09-01T12:00/PT24H&elements=max(air_temperature PT1H),min(air_temperature PT1H)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 29,
  "data" : [ {
    "referenceTime": "2008-09-..T12:00:00.000Z"
  } ]
}
    """


  @observations-examples-wsklima-example14.1
  Scenario: observations-examples-wsklima-example14.1

    Given a valid public MET API client ID

    When request_get
    # I retrieve 10-minute precipitation observations for 12 UTC at Blindern in May 2016
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=R31/2016-05-01T12:00:00.000Z/2016-05-01T12:00:00.000Z/PT24H&elements=sum(precipitation_amount PT10M)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 31,
  "data" : [ {
    "referenceTime": "2016-05-..T12:00:00.000Z"
  } ]
}
    """


  @observations-examples-wsklima-example14.2
  Scenario: observations-examples-wsklima-example14.2

    Given a valid public MET API client ID

    When request_get
    # I retrieve all 10-minute precipitation observations for Blindern in May 2016
    """
    observations/v0.jsonld?sources=SN18700:0&referencetime=2016-05-01T00:00:00.000Z/2016-06-01T00:00:00.000Z&elements=sum(precipitation_amount PT10M)
    """

    Then response_jsonSubset_200
    # gets a full set of data
    """
{
  "totalItemCount": 4464,
  "data" : [ {
    "referenceTime": "2016-05-..T..:..:00.000Z"
  } ]
}
    """


  @observations-examples-wsklima-example15.1
  Scenario: observations-examples-wsklima-example15.1

    Given a valid public MET API client ID

    When request_get
    # I look up which observations are available from Ekofisk
    """
    observations/availableTimeSeries/v0.jsonld?sources=SN76920
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "data" : [ {
    "sourceId": "SN76920:."
  } ]
}
    """


  @observations-examples-wsklima-example15.2
  Scenario: observations-examples-wsklima-example15.2

    Given a valid public MET API client ID

    When request_get
    # I request all of the max wind speed of gust 10-minute observations from Ekofisk
    """
    observations/v0.jsonld?sources=SN76920:0&referencetime=2007-01-26T06:00:00.000Z/2013-11-30T13:00:00.000Z&elements=max(wind_speed_of_gust PT10M)
    """

    Then response_jsonSubset_200
    # get a full set of data
    """
{
  "totalItemCount": 837,
  "data" : [ {
    "referenceTime": "20..-..-..T..:..:00.000Z"
  } ]
}
    """
