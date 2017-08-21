@elements @elements-examples-T2641
Feature: elements-examples-T2641
  # Examples specified in Phabricator task T2641.

  # Note: Example 1 is already covered in the scenario with tag `@elements-non-existent-legacy` (file `id-legacy-cf.feature`)).

  @elements-examples-T2641-example2
  Scenario: elements-examples-T2641-example2

    Given a valid public MET API client ID

    When request_get
    """
    elements/v0.jsonld?legacyElementCodes=TAN
    """

    Then response_jsonSubset_200
    """
{
  "@type" : "ElementResponse",
  "apiVersion" : "v0",
  "currentItemCount" : 7,
  "itemsPerPage" : 7,
  "offset" : 0,
  "totalItemCount" : 7,
  "data" : [ {
    "id" : "min\\(air_temperature P1D\\)",
    "name" : "Air temperatur",
    "description" : "Lowest observed temperature in the given period.",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "P1D",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN", "TAND", "TAN_24", "X1TAN_12" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature P1M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this hour/day \\(from 18 to 18\\)/month.",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "P1M",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature P1Y\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this year \\(from 18 to 18\\).",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "P1Y",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature P3M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this season \\(from 18 to 18\\).",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "P3M",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature P6M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest noted temperature this 6 months of summer or winter \\(from 18 to 18\\).",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "P6M",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature PT10M\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest observed temperature in the given period.",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "PT10M",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "min\\(air_temperature PT1H\\)",
    "name" : "Minimum temperature",
    "description" : "Lowest observed temperature in the given period.",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "air_temperature",
      "method" : "min",
      "period" : "PT1H",
      "methodDescription" : "Minimum value observed or calculated in the given period"
    },
    "category" : "Temperature",
    "legacyConvention" : {
      "elementCodes" : [ "TAN", "X1TAN", "X2TAN" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "air_temperature",
      "cellMethod" : "time: minimum",
      "unit" : "K",
      "status" : "44"
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
  "@context" : "https://data.met.no/schema",
  "@type" : "ElementResponse",
  "apiVersion" : "v0",
  "license" : "https://creativecommons.org/licenses/by/3.0/no/",
  "currentItemCount" : 2,
  "itemsPerPage" : 2,
  "offset" : 0,
  "totalItemCount" : 2,
  "data" : [ {
    "id" : "mean\\(soil_temperature PT1H\\)",
    "name" : "Mean soil temperature",
    "description" : "Soil temperature at given depth \\(default 10 cm\\), mean of 60 minute-values from the last hour",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "soil_temperature",
      "method" : "mean",
      "period" : "PT1H",
      "methodDescription" : "Standard arithmetic mean value for the given period"
    },
    "category" : "Soiltemperature",
    "sensorLevels" : {
      "levelType" : "depth_below_surface",
      "unit" : "cm",
      "defaultValue" : 10,
      "values" : [ 1, 2, 5, 10, 20, 30, 50, 100 ]
    },
    "legacyConvention" : {
      "elementCodes" : [ "TJM", "TJM1", "TJM10", "TJM100", "TJM2", "TJM20", "TJM30", "TJM5", "TJM50" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "soil_temperature",
      "cellMethod" : "time: mean",
      "unit" : "K",
      "status" : "44"
    }
  }, {
    "id" : "soil_temperature",
    "name" : "Soil temperature",
    "description" : "Soil temperature at given depth \\(default 10 cm\\), now value",
    "unit" : "degC",
    "status" : "CF-name",
    "calculationMethod" : {
      "baseName" : "soil_temperature"
    },
    "category" : "Soiltemperature",
    "sensorLevels" : {
      "levelType" : "depth_below_surface",
      "unit" : "cm",
      "defaultValue" : 10,
      "values" : [ 0, 1, 5, 10, 15, 20, 25, 30, 40, 45, 50, 80, 95, 100, 120, 160, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 670, 700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1500, 1750, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5250, 6000, 7000, 8000, 8500, 9000, 9500, 9750, 10000 ]
    },
    "legacyConvention" : {
      "elementCodes" : [ "TJ0", "TJ1", "TJ10", "TJ100", "TJ1000", "TJ10000", "TJ1100", "TJ120", "TJ1200", "TJ1300", "TJ1400", "TJ15", "TJ1500", "TJ160", "TJ1750", "TJ20", "TJ200", "TJ2000", "TJ25", "TJ250", "TJ2500", "TJ30", "TJ300", "TJ3000", "TJ350", "TJ3500", "TJ40", "TJ400", "TJ4000", "TJ45", "TJ450", "TJ4500", "TJ5", "TJ50", "TJ500", "TJ5000", "TJ5250", "TJ550", "TJ600", "TJ6000", "TJ650", "TJ670", "TJ700", "TJ7000", "TJ750", "TJ80", "TJ800", "TJ8000", "TJ850", "TJ8500", "TJ900", "TJ9000", "TJ95", "TJ950", "TJ9500", "TJ9750", "X1TJ1000", "X1TJ1100", "X1TJ120", "X1TJ1300", "X1TJ1500", "X1TJ160", "X1TJ20", "X1TJ200", "X1TJ250", "X1TJ300", "X1TJ350", "X1TJ40", "X1TJ400", "X1TJ500", "X1TJ700", "X1TJ80", "X1TJ900", "X1TJM10", "X1TJM20", "X1TJM50" ],
      "unit" : "degC"
    },
    "cfConvention" : {
      "standardName" : "soil_temperature",
      "unit" : "K",
      "status" : "44"
    }
  } ]
}
    """
