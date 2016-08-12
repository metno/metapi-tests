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

package stepdefs.basic

import cucumber.api.scala.{EN, ScalaDsl}
import org.scalatest.Matchers
import play.api.libs.ws.WSAuthScheme.BASIC
import play.api.libs.ws.ning.NingWSClient
import play.mvc.Http._
import scala.concurrent.Await
import scala.util.{Failure, Success, Try}
import stepdefs.Util._


class Basic extends ScalaDsl with EN with Matchers {

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get toplevel page" (file: get_toplevel_page.feature)

  When("""^I make an HTTP GET request for /$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + "/").get()
  }

  Then("""^I should get a response with status code = 200 and body containing 'API Overview'$"""){ () =>
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) =>
        assertResult(Status.OK, formatResponseBody(response.body)) {
          response.status
        }
        assert(response.body.contains("API Overview"), formatResponseBody(response.body))
      case Failure(error) =>
        throw error
    }
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get hello" (file: get_hello.feature)

  When("""^I make an HTTP GET request for /tests/hello$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + "/tests/hello").get()
  }

  Then("""^I should get a response with status code = 200 and body = 'Hello to you too!'""") { () =>
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) =>
        assertResult(Status.OK, formatResponseBody(response.body)) {
          response.status
        }
        assertResult("Hello to you too!", formatResponseBody(response.body)) {
          response.body.trim()
        }
      case Failure(error) =>
        throw error
    }
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get /tests/secureHello unauthenticated" (file: get_secure_hello_unauthenticated.feature)

  When("""^I make an HTTP GET request for /tests/secureHello without passing a valid client ID$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + "/tests/secureHello").get()
  }

  Then("""^I should get a response with status code = 401 and body = 'Missing authentication token!'""") { () =>
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) =>
        assertResult(Status.UNAUTHORIZED, formatResponseBody(response.body)) {
          response.status
        }
        assertResult("Missing authentication token", formatResponseBody(response.body)) {
          response.body.trim()
        }
      case Failure(error) =>
        throw error
    }
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Steps used only in scenario "Get /tests/secureHello authenticated" (file: get_secure_hello_authenticated.feature)

  When("""^I make an HTTP GET request for /tests/secureHello, passing a valid client ID$"""){ () =>
    futureResponse = NingWSClient().url(metapiBase + "/tests/secureHello")
      .withAuth(clientId, "", BASIC).get()
  }

  Then("""^I should get a response with status code = 200 and body = 'Hello to you too, securely!'""") { () =>
    Try(Await.result(futureResponse, timeout)) match {
      case Success(response) =>
        assertResult(Status.OK, formatResponseBody(response.body)) {
          response.status
        }
        assertResult("Hello to you too, securely!", formatResponseBody(response.body)) {
          response.body.trim()
        }
      case Failure(error) =>
        throw error
    }
  }

}
