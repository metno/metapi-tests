# metapi-tests

Play project that uses Cucumber to run acceptance (end-to-end) tests against a stand-alone MET API service.


Basic usage
-----------

Executing the following command:

  `METAPIBASE=<first part of URL> sbt test`

(e.g. `METAPIBASE=https://staging-data.met.no sbt test`)

will run all the tests (more precisely, all the test _scenarios_ defined in Gherkin *.feature files) and generate an HTML report in

  `target/cucumber-report/`

and a JSON report in

  `target/cucumber-report.json`


Test an authenticating server
-----------------------------

Specify the client ID to test a server with authentication enabled (i.e. where auth.active has not been set to false in application.conf):

  `METAPIBASE=... CLIENTID=<client ID> sbt test`

(e.g. `METAPIBASE=https://staging-data.met.no CLIENTID=a8c7ae79-f3a7-4d60-51e8-2b610817d438 TIMEOUTMILLISECONDS=10000 sbt test`)

Follow instructions on https://staging-data.met.no to get a client ID.

By default, authentication is skipped.


Specify a timeout for the server
--------------------------------

The server timeout can be set like this:

  `METAPIBASE=... TIMEOUTMILLISECONDS=<http request timeout> sbt test`

If the server does not respond to an http request within this timeout, the test in question is flagged as failed.

The default value is 10000 (i.e. 10 secs).


Tags
----

By default, all scenarios are run. To run scenarios for certain tags only, set the `CUCUMBER_OPTIONS` environment variable
like this:

  `CUCUMBER_OPTIONS="--tags @get_secure_hello_authenticated,@get_toplevel_page,@get_hello" METAPIBASE=... ...`

**Note 1:** The tag list cannot contain spaces.

**Note 2:** The tag itself cannot contain certain characters, like colons (':').

Scenarios are also tagged according to module. The following command runs all scenarios for the observations module:

  `CUCUMBER_OPTIONS="--tags @observations" METAPIBASE=... ...`

while the following command runs those of the elements module:

  `CUCUMBER_OPTIONS="--tags @elements" METAPIBASE=... ...`

and so on.

Here's a quick way to list tags associated with each scenario:

`find src -name \*.feature | xargs grep @`


Scenario names must be unique
-----------------------------

**Important:** Scenario names (the free text following the `Scenario:` keyword) must be globally unique within the same test run even if they are located in different .feature files and/or under different `Feature:` keywords.

Executing two scenarios with the same name will be considered multiple executions of the same scenario. Cucumber might consider the overall test execution as passed (i.e. the test runner process eventually exiting with status=0) as long as at least one of the multiple executions pass. A test failure might then go undetected.  


Test a local server that runs a single module
---------------------------------------------

To test a local server that runs a single module, such as the _frequencies_ module, we can use a combination of tags and `REQUESTPREFIX` like this:

  `CUCUMBER_OPTIONS="--tags @frequencies" METAPIBASE=localhost:9000 REQUESTPREFIX=frequencies/ sbt test`

In this case, all occurrences of "frequencies/" in the Gherkin source will be stripped from the URL before the HTTP request is executed.


Generic HTTP request/response testing
-------------------------------------

In acceptance testing based on Cucumber, it may be useful to decide if a certain JSON subset or a certain free text is present in a HTTP response.
This is supported by allowing the following format for the _When_ and _Then_ steps in a scenario:

```
  Scenario <test name>
    Given n/a

    When request_get
    # <optional comment>
    """
    < the part of the URI that comes after METAPIBASE/ >
    """

    Then response_<test type>_<expected status code>
    # <optional comment>
    """
    <expected response body (JSON subset or free text)>
    """
```

The test fails if any of the following conditions become true:

* The expected status code differs from the actual one.

* Comparison of the expected response body with the actual one fails according to the _test type_.

Currently, `jsonSubset`, `notJsonSubset`, `contains`, `notContains`, and `statusOnly` are supported for test type:

* The `jsonSubset` test checks if the expected response body (if non-empty) is a JSON subset of the actual response body:
At any point in the expected JSON structure, the toplevel keys of an _object_ must be a subset of the toplevel keys of the corresponding object in the actual structure.
For an _array_, the items in the expected structure must be a subset of the items of the corresponding array in the actual structure.
Array items must also occur in the same order.

* The `notJsonSubset` test is simply the negation of `jsonSubset`, i.e. it fails iff `jsonSubset` would have passed.

* The `contains` test checks if the expected response body is contained within the actual response body.

* The `notContains` test is simply the negation of `contains`, i.e. it fails iff `contains` would have passed.

* The `statusOnly` test is for cases where we only care about the status code (and not the response body).
**Note:** You still need to specify the docstring below the first line of the step even if it is ignored in this case:
```
    Then response_statusOnly_400
    """
    n/a
    """
```


The following example shows how to verify that the response body contains a certain JSON subset but not a certain other JSON subset:

```
  Scenario <test name>
    Given ...

    When ...

    Then response_jsonSubset_200
    """
    <JSON subset that must occur in the response body>
    """

    And response_notJsonSubset_200
    """
    <JSON subset that must NOT occur in the response body>
    """
```


The following example shows how to check that the response body contains a certain free text but not a certain other free text:

```
  Scenario <test name>
    Given ...

    When ...

    Then response_contains_200
    """
    <free text that must occur in the response body>
    """

    Then response_notContains_200
    """
    <free text that must NOT occur in the response body>
    """
```


The expected response body may contain regular expressions. In the case of the `jsonSubset` and `notJsonSubset` test types, only non-collection values can be
regular expressions, i.e. structural characters (`[`, `]`, `{`, `}`, and `,`) are not allowed if they are meant to define structure (of arrays and objects)
in that particular case.

In the case of the `jsonSubset` and `notJsonSubset` test types, backslashes must be escaped:

```
      Then response_jsonSubset_200
      """
      {
         "foo1": "bar",       ----> matches the string "bar"
         "foo2": "b[0-9]+r",  ----> matches a string beginning with the character 'b' followed by one or more decimal digits, followed by the character 'r'
         "foo3": "b\\d+r",    ----> ditto
         "foo4": "ba[r|z]",   ----> matches the string "bar" or the string "baz"
         "foo5": "ba*r",      ----> matches a string beginning with the character 'b' followed by zero or more 'a' characters, followed by the character 'r'
         "foo6": "ba\\*r",    ----> matches the string "ba*r"
         "foo7": ".+",        ----> matches one or more characters"
         "foo8": "ba\\(r\\)"  ----> matches the string "ba(r)"
      }
      """
```


In the case of the `contains` and `notContains` test types, backslashes need not be escaped:

```
      Then response_contains_200
      """
      b\d+r    ----> matches a string beginning with the character 'b' followed by one or more decimal digits, followed by the character 'r'
      """

      ...
      """
      ba\*r    ----> matches the string "ba*r"
      """

      ...
      """
      ba\(r\)  ----> matches the string "ba(r)"
      """

```


This example asserts that the response body (regardless of format!) contains a station mumber (like "SN18700") but not the word "foobar":

```
      Then response_contains_200
      """
      SN\d+
      """

      And response_notContains_200
      """
      foobar
      """
```
