import sbt._

class Plugins(info: ProjectInfo) extends PluginDefinition(info) {
  val codaRepo    = "Coda Hale's Repository" at "http://repo.codahale.com/"
  val assemblySbt = "com.codahale" % "assembly-sbt" % "0.1.1"
}
