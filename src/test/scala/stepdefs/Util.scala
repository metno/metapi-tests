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

  val timeout = Duration(timeoutMilliseconds, MILLISECONDS)


  def formatResponseBody(responseBody: String): String = {
    s"""
---BEGIN response body ------------------------------------
${responseBody}
---END response body --------------------------------------
"""
  }

  // Checks if s1 is contained in s2. Throws an exception if not.
  def assertContains(s1: String, s2: String): Unit = {
    val ptn = s1.r
    if (ptn.findFirstIn(s2) == None) {
      throw new Exception(s"expression ${ptn} not found in other string")
    }
  }

  object TestType extends Enumeration {
    type TestType = Value
    val JSONSUBSET, CONTAINMENT = Value
  }

  def formatComparison(testType: TestType.TestType, s1: String, s2: String, mismatch: Boolean): String = {
    val maxSize = 1000
    var s1x = s1.substring(0, Math.min(s1.length, maxSize))
    if (maxSize < s1.length) { s1x = s1x + "\n[" + (s1.length - maxSize) + " characters omitted]" }
    var s2x = s2.substring(0, Math.min(s2.length, maxSize))
    if (maxSize < s2.length) { s2x = s2x + "\n[" + (s2.length - maxSize) + " characters omitted]" }

    val not = if (mismatch) "not " else ""

    var f1: String = ""
    var f2: String = ""
    testType match {
      case TestType.JSONSUBSET => {
        f1 = "JSON value"
        f2 = "a subset of"
      }
      case TestType.CONTAINMENT => {
        f1 = "string"
        f2 = "contained in"
      }
    }

    s"""
---BEGIN ${f1} 1 ------------------------------------
$s1x
---END ${f1} 1 --------------------------------------

is ${not}${f2}

---BEGIN ${f1} 2 ------------------------------------
$s2x
---END ${f1} 2 --------------------------------------
"""
  }

  def formatContainmentComparison(s1: String, s2: String, mismatch: Boolean): String = {
    formatComparison(TestType.CONTAINMENT, s1, s2, mismatch)
  }
}
