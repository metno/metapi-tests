name := "metapi-tests"

version := "0.1-SNAPSHOT"

scalaVersion := "2.11.8"

libraryDependencies ++= Seq(
  "org.scalatest" % "scalatest_2.11" % "2.2.6" % "test",
  "info.cukes" % "cucumber-scala_2.11" % "1.2.4",
  "org.scala-lang" % "scala-library" % "2.11.8",
  "org.scala-lang" % "scala-reflect" % "2.11.8",
  "org.scala-lang.modules" % "scala-xml_2.11" % "1.0.4",
  "org.scala-lang.modules" % "scala-parser-combinators_2.11" % "1.0.4",
  "info.cukes" % "cucumber-junit" % "1.2.4",
  "info.cukes" % "cucumber-picocontainer" % "1.2.4",
  "junit" % "junit" % "4.12",
  "com.novocode" % "junit-interface" % "0.11" % "test",
  ws
)
