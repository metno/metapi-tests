@frequencies @frequencies-rainfall-gridded
Feature: frequencies-rainfall-gridded-dataset
  # Acceptance tests for the case when the query string field 'sources' specifies a gridded dataset.


  @frequencies-rainfall-gridded-missing-location
  Scenario: frequencies-rainfall-gridded-missing-location

    # Omitting the location should give an error.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?sources=idf_bma1km
    """

      Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "no location found for gridded dataset"
  }
}
    """


  @frequencies-rainfall-gridded-malformed-location
  Scenario: frequencies-rainfall-gridded-malformed-location

# Specifying a malformed location should give an error.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?sources=idf_bma1km&location=foo
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "foo is not a valid point",
    "help" : "Supported syntax: location=POINT\\(<longitude degrees> <latitude degrees>\\)"
  }
}
    """


  @frequencies-rainfall-gridded-location-with-no-data
  Scenario: frequencies-rainfall-gridded-location-with-no-data

# Specifying a location with no data should give an error.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?sources=idf_bma1km&location=point(1 1)
    """

    Then response_jsonSubset_404
    """
 {
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "Could not find rainfall IDF data at this location in the gridded data and/or for this combination of durations and frequencies",
    "help" : "Ensure that the location is over a region where IDF data exists and that the combination of durations and frequencies is valid"
  }
}
   """


  @frequencies-rainfall-gridded-location-with-data
  Scenario: frequencies-rainfall-gridded-location-with-data

# Specifying a location with data should give successful response.

    Given a valid public MET API client ID

    When request_get
    """
    frequencies/rainfall/v0.jsonld?sources=idf_bma1km&location=point(10 60)
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "RainfallIDFResponse",
  "apiVersion" : "v0",
  "currentItemCount" : 1,
  "itemsPerPage" : 1,
  "offset" : 0,
  "totalItemCount" : 1,
  "data" : [ {
    "sourceId" : "idf_bma1km",
    "version" : "1",
    "geometry" : {
      "@type" : "Point",
      "coordinates" : [ 10, 60 ]
    },
    "numberOfSeasons" : 59,
    "unit" : "l/s\\*Ha",
    "values" : [ {
      "intensity" : ".+",
      "duration" : ".+",
      "frequency" : ".+"
    } ]
  } ]
}
   """
