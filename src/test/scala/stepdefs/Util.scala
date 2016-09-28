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

import play.api.libs.ws.WSResponse
import scala.concurrent.Future
import scala.concurrent.duration._

object Util {
  // scalastyle:off null
  var futureResponse: Future[WSResponse] = null
  // scalastyle:on null


  def metapiBase: String = util.Try(sys.env("METAPIBASE")) match {
    case util.Success(x) => x
    case util.Failure(ex) => throw new Exception("METAPIBASE not found")
  }

  def requestPrefix: String = util.Try(sys.env("REQUESTPREFIX")) match {
    case util.Success(x) => x
    case util.Failure(ex) => ""
  }

  def clientId: String = util.Try(sys.env("CLIENTID")) match {
    case util.Success(x) => x
    case util.Failure(ex) => ""
  }

  def timeoutMilliseconds: Int = util.Try(sys.env("TIMEOUTMILLISECONDS")) match {
    case util.Success(x) => x.toInt
    case util.Failure(ex) => 10000
  }

  def formatResponseBody(responseBody: String): String = {
    s"""
---BEGIN response body ------------------------------------
${responseBody}
---END response body --------------------------------------
"""
  }

  val timeout = Duration(timeoutMilliseconds, MILLISECONDS)
}
