@sources @sources-overall
Feature: sources-overall
  # Overall acceptance tests.


  @sources-empty-request
  Scenario: sources-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld
    """

    Then response_jsonSubset_200
    # Note that the following response is just one of many possible variations.
    """
{
  "@context" : ".+",
  "@type" : "SourceResponse",
  "apiVersion" : ".+",
  "license" : ".+",
  "createdAt" : ".+",
  "queryTime" : ".+",
  "currentItemCount" : "\\d+",
  "itemsPerPage" : "\\d+",
  "offset" : "\\d+",
  "totalItemCount" : "\\d+",
  "currentLink" : ".+",
  "data" :
  [
    {
      "@type" : ".+",
      "id" : ".+",
      "name" : ".+",
      "country" : ".+",
      "geometry" : {
        "@type" : ".+",
        "coordinates" : [ ".+", ".+" ]
      },
      "levels" :
      [
        {
          "levelType" : ".+",
          "value" : ".+",
          "unit" : ".+"
        }
      ],
      "validFrom" : "\\d\\d\\d\\d-\\d\\d-\\d\\d"
    }
  ]
}
    """


  @sources-unsupported-field
  Scenario: sources-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    sources/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: name, country, validtime, externalid, fields, ids, stationholder, types, geometry"
  }
}
    """
