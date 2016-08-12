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

package stepdefs

import cucumber.api.scala.{EN, ScalaDsl}
import org.scalatest.Matchers
import play.api.libs.json.Json
import play.mvc.Http._
import scala.concurrent.{Await, Future}
import scala.util.{Failure, Success, Try}
import stepdefs.Util._


// Note: EN=English (see for example https://jar-download.com/java-documentation-javadoc.php?a=cucumber-scala_2.11&g=info.cukes&v=1.2.4)
class Shared extends ScalaDsl with EN with Matchers {

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used by more than one scenario

  Given("""^n/a$"""){ () =>
    // nothing to be done in this case
  }

  Then("""^I should get a response with status code = 200 and a body in valid JSON-LD format""") { () =>
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) =>
        assertResult(Status.OK, formatResponseBody(response.body)) {
          response.status
        }
        Json.parse(response.body)
      case Failure(error) =>
        throw error
    }
  }

}
