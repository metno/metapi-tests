@elements @elements-examples-T2641
Feature: elements-examples-T2641
  # Examples specified in Phabricator task T2641.

  # Note: Example 1 is already covered in the scenario with tag `@elements-non-existent-legacy` (file `id-legacy-cf.feature`)).

  @elements-examples-T2641-example2
  Scenario: elements-examples-T2641-example2

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElemCodes=TAN
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ElementResponse",
  "totalItemCount" : 4,
  "data" : [ {
    "id" : "min\\(air_temperature 1M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this hour/day \\(from 18 to 18\\)/month.",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TAN" ],
      "category" : "Temperature",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "min",
      "unit" : "K",
      "status" : "28"
    }
  }, {
    "id" : "min\\(air_temperature T10M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this hour/day \\(from 18 to 18\\)/month.",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TAN" ],
      "category" : "Temperature",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "min",
      "unit" : "K",
      "status" : "28"
    }
  }, {
    "id" : "min\\(air_temperature T1H\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this hour/day \\(from 18 to 18\\)/month.",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TAN", "X1TAN", "X2TAN" ],
      "category" : "N/A",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "min",
      "unit" : "K",
      "status" : "28"
    }
  }, {
    "id" : "min\\(air_temperature T24H\\)",
    "name" : "Air temperatur",
    "description" : "Lowest noted temperature this hour/day \\(from 00 to 23\\)",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TAN", "TAND", "TAN_24", "X1TAN_12" ],
      "category" : "N/A",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "min",
      "unit" : "K",
      "status" : "28"
    }
  } ]
}
    """


  @elements-examples-T2641-example3
  Scenario: elements-examples-T2641-example3

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?cfStandardNames=soil_temperature
    """

    Then response_jsonSubset_200
    # Note inconsistencies between name and description! The test needs to be updated once this is fixed in the database ... TBD
    """
{
  "@type" : "ElementResponse",
  "totalItemCount" : 2,
  "data" : [ {
    "id" : "mean\\(soil_temperature T1H\\)",
    "name" : "Mean soil temperature \\(-10 cm\\)",
    "description" : "Mean soil temperature at 1 cm depth",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TJM", "TJM1", "TJM10", "TJM100", "TJM2", "TJM20", "TJM30", "TJM5", "TJM50" ],
      "category" : "Soiltemperature",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "soil_temperature",
      "cellMethod" : "mean",
      "unit" : "K",
      "status" : "28"
    }
  }, {
    "id" : "soil_temperature",
    "name" : "Mean soil temperature at 20 cm depth",
    "description" : "Mean soil temperature at 10 cm depth",
    "unit" : "degC",
    "legacyMetNoConvention" : {
      "elemCodes" : [ "TJ0", "TJ1", "TJ10", "TJ100", "TJ1000", "TJ10000", "TJ1100", "TJ120", "TJ1200", "TJ1300", "TJ1400", "TJ15", "TJ1500", "TJ160", "TJ1750", "TJ20", "TJ200", "TJ2000", "TJ25", "TJ250", "TJ2500", "TJ30", "TJ300", "TJ3000", "TJ350", "TJ3500", "TJ40", "TJ400", "TJ4000", "TJ45", "TJ450", "TJ4500", "TJ5", "TJ50", "TJ500", "TJ5000", "TJ5250", "TJ550", "TJ600", "TJ6000", "TJ650", "TJ670", "TJ700", "TJ7000", "TJ750", "TJ80", "TJ800", "TJ8000", "TJ850", "TJ8500", "TJ900", "TJ9000", "TJ95", "TJ950", "TJ9500", "TJ9750", "X1TJ1000", "X1TJ1100", "X1TJ120", "X1TJ1300", "X1TJ1500", "X1TJ160", "X1TJ20", "X1TJ200", "X1TJ250", "X1TJ300", "X1TJ350", "X1TJ40", "X1TJ400", "X1TJ500", "X1TJ700", "X1TJ80", "X1TJ900", "X1TJM10", "X1TJM20", "X1TJM50" ],
      "category" : "N/A",
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "soil_temperature",
      "unit" : "K",
      "status" : "28"
    }
  } ]
}
    """
