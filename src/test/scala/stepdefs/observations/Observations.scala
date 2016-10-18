/*
    MET-API

    Copyright (C) 2014 met.no
    Contact information:
    Norwegian Meteorological Institute
    Box 43 Blindern
    0313 OSLO
    NORWAY
    E-mail: met-api@met.no

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
    MA 02110-1301, USA
*/

package stepdefs.observations

import cucumber.api.scala.{EN, ScalaDsl}
import org.scalatest.Matchers
import play.api.libs.ws.WSAuthScheme.BASIC
import play.api.libs.ws.ning.NingWSClient
import stepdefs.Util._

class Observations extends ScalaDsl with EN with Matchers {

  When("""^I request observations with a valid source, referencetime and elementId$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a non-existent source$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN99999&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=max(air_temperature T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations for a non-existing referencetime period$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700&referencetime=1990-07-01T00:00:00/1990-09-01T00:00:00&elements=max(air_temperature T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a non-existing elementId$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700&referencetime=2004-07-01T00:00:00/2004-09-01T00:00:00&elements=weird_snow_depth_precipitation")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request air_temperature and wind_speed observations for all of the sensor numbers of a source SN3290$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN3290:all&referencetime=2013-08-01T00:00:00.000Z/2013-09-01T00:00:00.000Z&elements=wind_speed,air_temperature")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request air_temperature and wind_speed observations for sensor number 1 of a source SN3290$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN3290:1&referencetime=2013-08-01T00:00:00.000Z/2013-09-01T00:00:00.000Z&elements=wind_speed,air_temperature")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request air_temperature and wind_speed observations for sensor number 2 of a source SN3290$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN3290:2&referencetime=2013-08-01T00:00:00.000Z/2013-09-01T00:00:00.000Z&elements=wind_speed,air_temperature")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime inside the period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-03-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime overlapping the lower bounds of a period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=1992-11-01T00:00:00.000Z/1993-01-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime overlapping the upper bounds of a period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=2006-03-01T00:00:00.000Z/2006-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime overlapping both bounds of a period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=2006-03-20T00:00:00.000Z/2007-07-30T00:00:00.000Z&elements=surface_temperature")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime exactly equal to the bounds of a period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=2006-04-20T00:00:00.000Z/2007-06-30T00:00:00.000Z&elements=surface_temperature")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime before the period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=1992-03-01T00:00:00.000Z/1992-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime period where the startvalue and endvalue both match with observations$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=1996-01-01T00:00:00.000Z/1996-01-02T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with a referencetime after the period of a time series$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=2007-03-01T00:00:00.000Z/2007-05-01T00:00:00.000Z&elements=mean(air_temperature%20T1H)")
      .withAuth(clientId, "", BASIC).get()
  }

  When("""^I request observations with multiple elementIds$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/v0.jsonld?sources=SN18700:0&referencetime=1961-11-01T00:00:00.000Z/1962-02-01T00:00:00Z&elements=high_type_cloud,%20low_type_cloud")
      .withAuth(clientId, "", BASIC).get()
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get time series" (file: get_time_series.feature)

  When("""^I make an HTTP GET request for /observations/timeSeries/v0.jsonld\?sources=SN(\d+)$"""){ (station:Int) =>
    futureResponse = NingWSClient().url(metapiBase + s"/observations/availableTimeSeries/v0.jsonld?sources=SN$station")
      .withAuth(clientId, "", BASIC).get()
  }

}
