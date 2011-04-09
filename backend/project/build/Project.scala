import sbt._

class Project(info: ProjectInfo) extends DefaultProject(info) {
  val sonatypeRepo    = MavenRepository("Sonatype Releases", "http://oss.sonatype.org/content/repositories/releases")
  val scalaSnapshots  = MavenRepository("Scala-tools.org Repo", "http://scala-tools.org/repo-snapshots/")
  val scalableRepo    = MavenRepository("Akka Repo",            "http://scalablesolutions.se/akka/repository")
  val jbossReleases   = MavenRepository("JBoss Releases", "http://repository.jboss.org/nexus/content/groups/public/")

  val blueeyesRelease = "com.github.blueeyes" % "blueeyes" % "0.2.7" % "compile"
}
