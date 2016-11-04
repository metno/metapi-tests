@locations @locations-overall
Feature: locations/
  Overall acceptance tests.


  @locations-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld
    """

    Then response_jsonSubset_200
    """
{
  "@context" : ".+",
  "@type" : "LocationResponse",
  "apiVersion" : ".+",
  "license" : ".+",
  "createdAt" : ".+",
  "queryTime" : ".+",
  "currentItemCount" : "\\d+",
  "itemsPerPage" : "\\d+",
  "offset" : "\\d+",
  "totalItemCount" : "\\d+",
  "currentLink" : ".+",
  "data" : [ {
    "name" : ".+",
    "feature" : ".+",
    "geometry" : {
      "@type" : ".+",
      "coordinates" : [ ".+", ".+" ]
    }
  } ]
}
    """


  @locations-unsupported-field
  Scenario: unsupported field

    Given a valid public MET API client ID

    When request_get
    """
    locations/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: names, geometry, fields"
  }
}
    """
