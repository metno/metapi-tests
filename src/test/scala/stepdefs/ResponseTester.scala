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

import org.scalatest.Matchers
import play.api.libs.json._
import play.api.libs.ws.WSResponse
import stepdefs.JsonUtil.{assertSubsetOf, formatSubsetComparison}
import scala.util.{Failure, Success, Try}


object ResponseTester extends cucumber.api.scala.ScalaDsl with Matchers {

  def exec(testName: String, testType: String, expStatusCode: Int, expBody: String, response: WSResponse): Unit = {

    // check status code
    assertResult(expStatusCode, s"(status code mismatch; test name: $testName)") {
      response.status
    }

    // check response body
    testType match {
      case "jsonSubset" => {
        Try(assertSubsetOf(Json.parse(expBody), Json.parse(response.body.toString))) match {
          case Failure(e) => { // propagate with additional info
            throw new Exception(
              "(JSON subset mismatch)" + JsonUtil.formatSubsetComparison(expBody, response.body.toString, true) + e.getMessage)
          }
          case Success(()) => // nothing to be done
        }
      }

      case "notJsonSubset" => {
        Try(assertSubsetOf(Json.parse(expBody), Json.parse(response.body.toString))) match {
          case Success(()) => { // propagate
            throw new Exception("JSON subset match (unexpected))" + JsonUtil.formatSubsetComparison(expBody, response.body.toString, false))
          }
          case Failure(e) => // expected, so nothing to be done
        }
      }

      //case "<TYPE 3>" => ...
      // ...

      case other => throw new Exception(s"unsupported response test type: $other")
    }
  }
}
