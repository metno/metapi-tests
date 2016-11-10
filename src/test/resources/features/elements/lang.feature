@elements @elements-lang
Feature: elements/?lang
  Acceptance tests for the query string field 'lang'.

  @elements-valid-lang-en-US
  Scenario: valid language en-US

    Specifying lang=en-US should return appropriate data.

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=cloud_area_fraction&lang=en-US
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ElementResponse",
  "data" : [ {
    "id" : "cloud_area_fraction",
    "name" : "Cloud cover",
    "description" : "Total cloud cover, code 0 - 8 \\(0 = sky clear, 1-8 = octas of sky covered. Code -3 = cloud cover can not be estimated due to fog, drifting snow etc. Code -3 is presented as '.'  \\(in synop code=9\\)\\)"
  } ]
}
    """


  @elements-valid-lang-nb-NO
  Scenario: valid language nb-NO

  Specifying lang=nb-NO should return appropriate data.

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=cloud_area_fraction&lang=nb-NO
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ElementResponse",
  "data" : [ {
    "id" : "cloud_area_fraction",
    "name" : "Skydekke",
    "description" : "Samlet skydekke, kodetall 0-8 \\(0 = skyfritt, 1-8 = åttedeler av himmelen. Kode -3 = mengden av skyer kan ikke bedømmes pga tåke, snøfokk eller lignende. -3 presenteres som '.'  \\(i synop kode=9\\)\\)"
  } ]
}
    """


  @elements-valid-lang-nn-NO
  Scenario: valid language nn-NO

  Specifying lang=nn-NO should return appropriate data.

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=cloud_area_fraction&lang=nn-NO
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ElementResponse",
  "data" : [ {
    "id" : "cloud_area_fraction",
    "name" : "Skydekke",
    "description" : "Samla skydekke, kodetal 0-8 \\(0 = skyfritt, 1-8 = åttedelar av himmelen. Kode -3 = mengda av skyer er ikkje mogleg å sjå pga tåke, snøfokk eller liknande. -3 presenterast som '.'  \\(i synop kode=9\\)\\)"
  } ]
}
    """


  @elements-invalid-lang
  Scenario: invalid language

  Specifying an invalid language should result in 400/BadRequest

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?ids=cloud_area_fraction&lang=foobar
    """

    Then response_jsonSubset_400
    """
{
  "@type" : "ErrorResponse",
  "error" : {
    "code" : 400,
    "message" : "Bad Request",
    "reason" : "Invalid language in the query parameter: foobar",
    "help" : "Supported languages: en-US, nb-NO, nn-NO"
  }
}
    """
