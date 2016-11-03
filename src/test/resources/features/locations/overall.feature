Feature: locations/

  @locations @locations-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given n/a

    When request_get empty request
    """
    locations/v0.jsonld
    """

    Then response_jsonSubset_200 empty request
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


  @locations @locations-unsupported-field
  Scenario: unsupported field

    Given n/a

    When request_get unsupported field
    """
    locations/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400 unsupported field
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
