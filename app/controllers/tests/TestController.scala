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

package controllers.tests

/**
 * Simple Controller to run calls on the API
 *
 * Specs2 does not permit Logging calls during testing (apparently due to an
 * issue with memory leaks). Editing and running the controller provides a
 * quick way to check that the calls you're doing on the API actually return
 * what you expect them to.
 */

import play.api._
import play.api.mvc._
import com.google.common.io._
import scalaj.http._

import play.api.Logger

/**
 * TestController is not used for actual testing
 *
 * This is just convenience code to make it easier to try things out before
 * implementing the tests (Specs2 does not allow Logging in the test code).
 */
object TestController extends Controller {

  def callApi: Action[AnyContent] = Action {
    Ok(getApiBasic("/tests/secureHello", "cafebabe-feed-d00d-badd-5eaf00d5a1ad").body)
  }

  val uri = "https://localhost:9000"

  def getApiBasic(resource: String, clientId: String) : HttpResponse[String] = {
    val response = Http(uri + resource).header("Authorization", "Basic " + BaseEncoding.base64Url().encode(s"$clientId:".getBytes("UTF-8"))).asString
    Logger.debug("Test Debugger")
    Logger.debug(response.code.toString)
    Logger.debug(response.headers.toString)
    Logger.debug("x" + response.body + "x")
    response
  }


}
