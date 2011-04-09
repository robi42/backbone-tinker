import sbt._

class Project(info: ProjectInfo) extends DefaultProject(info) {
  val sonatypeRepo    = "Sonatype Releases"    at "http://oss.sonatype.org/content/repositories/releases"
  val scalaSnapshots  = "Scala-tools.org Repo" at "http://scala-tools.org/repo-snapshots/"
  val scalableRepo    = "Akka Repo"            at "http://scalablesolutions.se/akka/repository"
  val jbossReleases   = "JBoss Releases"       at "http://repository.jboss.org/nexus/content/groups/public/"

  val blueeyesRelease = "com.github.blueeyes" % "blueeyes" % "0.2.7" % "compile"
}
