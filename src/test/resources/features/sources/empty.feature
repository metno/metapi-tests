Feature: sources/


  @sources @sources-empty-request
  Scenario: empty request

    An empty query string should return a reasonable result.

    Given n/a

    When request_get empty request
    """
    sources/v0.jsonld
    """

    Then response_jsonSubset_200 empty request
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
