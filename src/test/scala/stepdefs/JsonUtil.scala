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

import play.api.libs.json.{JsArray, JsObject, JsValue, Json}

import scala.collection.Set
import scala.util.Success
import Util.{TestType, formatComparison}


object JsonUtil {

  // Checks if val1 is a subset of val2. Throws an exception if not.
  def assertSubsetOf(val1: JsValue, val2: JsValue): Unit = val1 match {
    case v if isArray(v) => assertArraySubsetOf(v.asOpt[JsArray].get, val2)
    case v if isObject(v) => assertObjectSubsetOf(v.asOpt[JsObject].get, val2)
    case v => assertStringMatch(v, val2)
  }

  private def assertArraySubsetOf(arr1: JsArray, val2: JsValue): Unit = {
    if (!isArray(val2)) {
      throw new Exception("comparing array with non-array: " + val2)
    }

    val arr2: JsArray = val2.asOpt[JsArray].get

    var i1: Int = 0
    var i2: Int = 0
    if (arr1.value.isEmpty) {
      // scalastyle:off return
      return // an empty array matches any other array by definition
      // scalastyle:on
    }

    while (true) {
      // assert(i1 < arr1.value.size)
      // assert(i2 < arr2.value.size)
      val subsetMatch: Boolean = util.Try(assertSubsetOf(arr1(i1).get, arr2(i2).get)) == util.Success(()) // don't propagate any exception in this case!

      if (subsetMatch) {
        // pair matched, so advance both arrays
        i1 = i1 + 1
        i2 = i2 + 1
      } else {
        // pair did not match, so advance arr2 only
        i2 = i2 + 1
      }

      if (i1 == arr1.value.size) { // arr1 exhausted
        // scalastyle:off return
        return // all items matched
        // scalastyle:on
      }

      if (i2 == arr2.value.size) { // arr2 exhausted
        throw new Exception(s"value at index $i1 in array 1 not found in a valid range in array 2")
      }

    }

  }

  private def assertObjectSubsetOf(obj1: JsObject, val2: JsValue) = {
    if (!isObject(val2)) {
      throw new Exception("comparing object with non-object: " + val2)
    }

    val obj2: JsObject = val2.asOpt[JsObject].get

    val keys1: Set[String] = obj1.keys
    val keys2: Set[String] = obj2.keys

    if (!keys1.subsetOf(keys2)) {
      throw new Exception("object keys " + keys1 + " not a subset of keys " + keys2)
    }

    for (key <- keys1) {
      val subVal1:JsValue = (obj1 \ key).get
      val subVal2:JsValue = (obj2 \ key).get
      assertSubsetOf(subVal1, subVal2)
    }
  }

  private def stripDoubleQuotes(s: String): String = {
    if ((s.length > 1) && (s(0) == '\"') && (s(s.length - 1) == '\"')) {
      s.substring(1, s.length - 1)
    } else {
      s
    }
  }

  private def assertStringMatch(val1: JsValue, val2: JsValue) = {
    assert(!isCollection(val1))
    if (isCollection(val2)) {
      throw new Exception("comparing non-collection with collection: " + val2)
    }

    val s1: String = val1.toString().replaceAll("""\\\\""", """\\""")
    val s2: String = val2.toString()
    if ((!(s2 matches s1)) && (!(s2 matches stripDoubleQuotes(s1)))) {
      throw new Exception(">" + s2 + "< does not match >" + s1 + "<")
    }
  }

  private def isObject(jsonVal: JsValue): Boolean = { jsonVal.asOpt[JsObject].isDefined }
  private def isArray(jsonVal: JsValue): Boolean = { jsonVal.asOpt[JsArray].isDefined }
  private def isCollection(jsonVal: JsValue): Boolean = { isObject(jsonVal) || isArray(jsonVal) }

  def formatSubsetComparison(s1: String, s2: String, mismatch: Boolean): String = {
    formatComparison(TestType.JSONSUBSET, s1, s2, mismatch)
  }

  def formatSubsetComparison(jsonVal1: JsValue, jsonVal2: JsValue, mismatch: Boolean): String = {
    formatSubsetComparison(jsonVal1.toString(), jsonVal2.toString(), mismatch)
  }

  def test(): Unit = {
    // val jsonVal1: JsValue = Json.parse(
    //   """{ "b": "2", "a": "1", "f": 17.8, "arr1": [ {"q": 33, "r": 44}, {"w": 5} ], "obj1": { "c": "3", "d": "4"} }
    //   """)
    // Should pass:
    // val jsonVal2: JsValue = Json.parse(
    //   """{ "a": "1", "obj1": { "r": 22, "c": "3", "d": "4"}, "b": "2", "f": 17.8, "arr1": [ {"q": 33, "x": "foo", "r": 44},
    //      {"w": 5} ] }
    //   """)

    //val jsonVal1: JsValue = Json.parse("""{ "arr1": [ {"a": 1, "b": 2}, {"c": 3} ] }""")
    // Should pass (identical!):
    //val jsonVal2: JsValue = Json.parse("""{ "arr1": [ {"a": 1, "b": 2}, {"c": 3} ] }""")
    // Should pass (since items in arr1 is a subsequence of items in arr2):
    //val jsonVal2: JsValue = Json.parse("""{ "arr1": [ {"a": 1, "b": 2}, {"d": 4}, {"c": 3} ] }""")
    // Should fail:
    //val jsonVal2: JsValue = Json.parse("""{ "arr1": [ {"c": 3}, {"a": 1, "b": 2}, {"d": 4} ] }""") // should not work!

    val jsonVal1: JsValue = Json.parse("""{ "b": "2", "a": "1.2[0-9]{2}" }""")
    // Should pass (since regexp matches):
    val jsonVal2: JsValue = Json.parse("""{ "a": "1.234", "b": "2", "f": 17.8 }""")

    assertSubsetOf(jsonVal1, jsonVal2)
  }
}
