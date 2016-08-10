# metapi-tests

Play project that uses Cucumber to run acceptance (end-to-end) tests against a stand-alone MET API service.


Usage:
------

Executing the following command:

  `METAPIBASE=<first part of URL> CLIENTID=<client ID> TIMEOUTMILLISECONDS=<http request timeout> sbt test`

(e.g. METAPIBASE=https://staging-data.met.no CLIENTID=a8c7ae79-f3a7-4d60-51e8-2b610817d438 TIMEOUTMILLISECONDS=10000 sbt test)

will run all the Cucumber tests and generate an HTML report in

  `target/cucumber-report/`

and a JSON report in

  `target/cucumber-report.json`

(Follow instructions on https://staging-data.met.no to get a client ID.)


Tags:
-----

By default, all scenarios are run. To run scenarios for certain tags only, set the `CUCUMBER_OPTIONS` environment variable
like this:

  `CUCUMBER_OPTIONS="--tags @get_secure_hello_authenticated,@get_toplevel_page,@get_hello" METAPIBASE=... ...`

**Note:** The tag list cannot contain spaces!

Scenarios are also tagged according to module. The following command runs all scenarios for the observations module:

  `CUCUMBER_OPTIONS="--tags @observations" METAPIBASE=... ...`

while the following command runs those of the elements module:

  `CUCUMBER_OPTIONS="--tags @elements" METAPIBASE=... ...`

and so on.

Here's a quick way to list tags associated with each scenario:

`find src -name \*.feature | xargs grep @`
