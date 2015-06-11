name := """metapi-specs2"""

organization := "no.met.data"

version := "0.1-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := "2.11.6"

scalacOptions += "-feature"

javaOptions += "-Djunit.outdir=target/test-report"

ScoverageSbtPlugin.ScoverageKeys.coverageHighlighting := true

ScoverageSbtPlugin.ScoverageKeys.coverageMinimum := 80

ScoverageSbtPlugin.ScoverageKeys.coverageFailOnMinimum := true

ScoverageSbtPlugin.ScoverageKeys.coverageExcludedPackages := """
  <empty>;
  util.HttpStatus;views.html.swaggerUi.*;
  value.ApiResponse;
  ReverseApplication;
  ReverseAssets;
  Routes;
"""

scalacOptions += "-feature"

scalacOptions += "-language:postfixOps"

libraryDependencies ++= Seq(
  jdbc,
  anorm,
  cache,
  ws
)

libraryDependencies +=  "org.scalaj" %% "scalaj-http" % "1.1.4"

libraryDependencies <++= version { version =>
  Seq(
    "org.specs2"      %% "specs2-core"         ,
    "org.specs2"      %% "specs2-matcher-extra",
    "org.specs2"      %% "specs2-gwt"          ,
    "org.specs2"      %% "specs2-html"         ,
    "org.specs2"      %% "specs2-form"         ,
    "org.specs2"      %% "specs2-scalacheck"   ,
    "org.specs2"      %% "specs2-mock"         ,
    "org.specs2"      %% "specs2-junit"
  ).map(_ % "3.6.1")
}

libraryDependencies <++= version { version =>
  Seq(
    "io.spray"        %% "spray-can"   ,
    "io.spray"        %% "spray-client",
    "io.spray"        %% "spray-http"  ,
    "io.spray"        %% "spray-httpx" ,
    "io.spray"        %% "spray-util"
  ).map(_ % "1.3.3")
}

PlayKeys.devSettings += ("application.router", "tests.Routes")

resolvers ++= Seq(
  "metno repo" at "http://maven.met.no/content/groups/public",
  "scalaz-bintray" at "http://dl.bintray.com/scalaz/releases"
)
