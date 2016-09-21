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

package stepdefs.elements

import cucumber.api.scala.{EN, ScalaDsl}
import org.scalatest.Matchers
import play.api.libs.ws.WSAuthScheme.BASIC
import play.api.libs.ws.ning.NingWSClient
import stepdefs.Util._


class Elements extends ScalaDsl with EN with Matchers {

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get single element" (file: get_single_element.feature)

  When("""^I make an HTTP GET request for /elements/air_temperature/v0.jsonld\?lang=en-US$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + "/elements/air_temperature/v0.jsonld?lang=en-US")
      .withAuth(clientId, "", BASIC).get()
  }

}