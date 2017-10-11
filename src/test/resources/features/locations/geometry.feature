@locations @locations-geometry
Feature: locations-geometry
  # Acceptance tests for the query string field 'geometry'.


  @locations-invalid-geometry-example1
  Scenario: locations-invalid-geometry-example1

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?geometry=foobar
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "foobar is not a valid data.met.no MET API geometry specification"
   }
}
    """

  @locations-invalid-geometry-example2
  Scenario: locations-invalid-geometry-example2

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?geometry=POINT(11.40,63.85)
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "POINT\\(11.40,63.85\\) is not a valid data.met.no MET API geometry specification",
    "help" : "supported WKT syntax: POINT\\(lon lat\\), nearest\\(POINT\\(lon lat\\)\\), or POLYGON\\(\\(30 10, 40 40, 20 40, 10 20, 30 10\\)\\)"
  }
}
    """

  @locations-geometry-not-found-example1
  Scenario: locations-geometry-not-found-example1

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?geometry=POINT(11.40 2063.85)
    """

    Then response_jsonSubset_404
    """
{
  "error" : {
    "code" : 404,
    "message" : "Not found",
    "reason" : "No data found for this combination of query parameters"
  }
}
    """

  @locations-geometry-example1
  Scenario: locations-geometry-example1

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?geometry=POINT(11.400636 63.858653)
    """

    Then response_jsonSubset_200
    """
{
  "data" : [ {
    "name" : "Røra",
    "feature" : "Small town",
    "geometry" : {
      "@type" : "Point",
      "coordinates" : [ 11.400636, 63.858653 ]
    }
  } ]
}
    """
