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

import scala.concurrent.Await
import scala.util.{Failure, Success, Try}
import stepdefs.Util._


class GenericRequestResponse extends ScalaDsl with EN with Matchers {

  When("""^request_get$""") { (request: String) =>
    RequestTester.exec(request)
  }

  Then("""^response_([^_].+)_(\d+)$""") { (testType: String, expStatusCode:Int, expBody: String) =>
//    JsonUtil.test()
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) => ResponseTester.exec(testType, expStatusCode, expBody, response)
      case Failure(error) => throw error
    }
  }

}
