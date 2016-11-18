@elements @elements-overall
Feature: elements-overall
  # Overall acceptance tests.


  @elements-empty-request
  Scenario: elements-empty-request

    # An empty query string should return a reasonable result.

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld
    """

    Then response_jsonSubset_200
    """
{
  "@context" : ".+",
  "@type" : "ElementResponse",
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
      "id" : ".+",
      "name" : ".+",
      "description" : ".+",
      "unit" : ".+",
      "legacyMetNoConvention" : {
        "elemCodes" : [ ".+" ],
        "category" : ".+",
        "unit" : ".+"
      },
      "cfConvention" : {
        "standardName" : ".+",
        "unit" : ".+",
        "status" : ".+"
      }
    }
  ]
}
    """


  @elements-unsupported-field
  Scenario: elements-unsupported-field

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?foo=bar
    """

    Then response_jsonSubset_400
    """
{
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Unsupported field in query string: foo",
    "help" : "Supported fields: cfStandardNames, fields, ids, lang, legacyElemCodes"
  }
}
    """
