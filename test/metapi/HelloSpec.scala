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

package metapi

import org.specs2._

import specification.script.{GWT, StandardDelimitedStepParsers}

import com.google.common.io._

import scalaj.http._

//scalastyle:off public.methods.have.type
/**
 * Sample specification to call /tests
 *
 */
class HelloSpec extends Specification with GWT with StandardDelimitedStepParsers { def is = s2"""

  Verify that the API is functional.                                           ${testsHello.start}
    Given the client_id {nemo}
    When I do GET {/tests/hello}
    Then I expect HTTP code {200}
      And the reply {Hello to you too!}                                        ${testsHello.end}

  Verify that basic auth is functional.                                        ${testsSecureHello.start}
    Given the client_id {f8c2747c-5a8a-4a0c-995b-33165f3efc84}
    When I do GET {/tests/secureHello}
    Then I expect HTTP code {200}
      And the reply {Hello to you too, securely!}                              ${testsSecureHello.end}

  Verify that basic auth fails on a fake client-id.                            ${testsSecureHelloBogus.start}
    Given the client_id {bogus-client-id}
    When I do GET {/tests/secureHello}
    Then I expect HTTP code {401}                                              ${testsSecureHelloBogus.end}

"""

  val uri = "https://data.met.no"

  val testsHello =
    Scenario("testsHello")
      .given(aString)
      .when(aString)    { case resource :: clientId :: _ =>  getApi(resource) }
      .andThen(anInt)   { case expectedHTTPCode :: response :: _ => expectedHTTPCode == response.code }
      .andThen(aString) { case expectedResponse :: response :: _ => response.body.contains(expectedResponse) }

  val testsSecureHello =
    Scenario("testsSecureHello")
      .given(aString)
      .when(aString)    { case resource :: clientId :: _ =>  getApiBasic(resource, clientId) }
      .andThen(anInt)   { case expectedHTTPCode :: response :: _ => expectedHTTPCode == response.code }
      .andThen(aString) { case expectedResponse :: response :: _ => response.body.contains(expectedResponse) }

  val testsSecureHelloBogus =
    Scenario("testsSecureHelloBogus")
      .given(aString)
      .when(aString)    { case resource :: clientId :: _ =>  getApiBasic(resource, clientId) }
      .andThen(anInt)   { case expectedHTTPCode :: response :: _ => expectedHTTPCode == response.code }


  def getApi(resource: String) : HttpResponse[String] = Http(uri + resource).asString

  def getApiBasic(resource: String, clientId: String) : HttpResponse[String] =
    Http(uri + resource).header("Authorization", "Basic " + BaseEncoding.base64Url().encode(s"$clientId:".getBytes("UTF-8"))).asString

}
