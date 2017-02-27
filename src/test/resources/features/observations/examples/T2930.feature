@observations @observations-examples-T2930
Feature: observations-examples-T2930
  # Examples specified in Phabricator task T2930.
  # Each scenario in this file represents a type of problematic element. Specifying such elements alongside unproblematic elements would result in
  # strange effects, like expected data being returned for only a small subset of the unproblematic elements.

  @observations-examples-T2930-example1
  Scenario: observations-examples-T2930-example1
    # In this case, the observation value for the element is represented as a timestamp in the database.
    # Originally, only doubles were supported. So, although time series were correctly reported as being available for the element,
    # no values were extracted.

    Given a valid public MET API client ID

    When request_get
    """
    observations/v0.jsonld?sources=SN18700&referencetime=2016-11-01T00:00:00Z/2016-11-02T00:00:00Z&fields=value&elements=time_of_event_of_min(air_temperature P1M)
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ObservationResponse",
  "data" : [ {
    "sourceId" : "SN18700:0",
    "referenceTime" : "2016-11-01T00:00:00.000Z",
    "observations" : [ {
      "elementId" : "time_of_event_of_min\\(air_temperature P1M\\)",
      "value" : "2016-11-11 00:00:00.0",
      "performanceCategory" : "A",
      "exposureCategory" : "1"
    } ]
  } ]
}
    """

  @observations-examples-T2930-example2
  Scenario: observations-examples-T2930-example2
    # In this case, the element was mistakenly represented as the wrong type in a foreign data table in the proxy database.

    Given a valid public MET API client ID

    When request_get
    """
    observations/v0.jsonld?sources=SN18700&referencetime=2016-11-01T00:00:00Z/2016-11-02T00:00:00Z&fields=value&elements=visibility_in_air_horizontal
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ObservationResponse",
  "totalItemCount" : 6,
  "data" : [ {
    "sourceId" : "SN18700:0",
    "referenceTime" : "2016-11-01T06:00:00.000Z",
    "observations" : [ {
      "elementId" : "visibility_in_air_horizontal",
      "value" : 30000,
      "performanceCategory" : "A",
      "exposureCategory" : "1",
      "qualityCode" : 0
    } ]
  } ]
}
    """
