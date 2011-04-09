package bbt

import blueeyes.{BlueEyesServer, BlueEyesServiceBuilder}
import blueeyes.core.http.{HttpRequest => Request, HttpResponse => Response}
import blueeyes.core.http.MimeTypes._
import blueeyes.core.http.combinators.HttpRequestCombinators
import blueeyes.json.JsonAST._
import blueeyes.config.{ConfiggyModule, FilesystemConfiggyModule}
import blueeyes.persistence.mongo.{Mongo, RealMongoModule}
import blueeyes.persistence.mongo.MongoImplicits._
import com.google.inject.Guice
import net.lag.configgy.ConfigMap
import java.util.UUID

trait TodoServices extends BlueEyesServiceBuilder with HttpRequestCombinators {
  def mongo: Mongo = null // Guice DI.

  val todoService = service("todo", "1.0.0") {
    healthMonitor { monitor => context =>
      startup {
        Config(context.config, mongo)
      } ->
      request { config: Config =>
        import config._
        path("/todos") {
          produce(application/json) {
            get { request: Request[Array[Byte]] =>
              for {
                todos <- database(select() from collection)
              } yield Response[JValue](
                content = Some(JArray(todos.toList)), headers = xDomainAjax)
            } ~
            // For Ajax CORS preflight requests.
            options { request: Request[Array[Byte]] =>
              Response[JValue](headers = xDomainAjax)
            }
          } ~
          jvalue {
            post {
              refineContentType[JValue, JObject] { request: Request[JObject] =>
                val content = request.content.get
                val jFields = content.children.asInstanceOf[List[JField]]
                val uuid    = UUID.randomUUID().toString
                val idField = List(JField("id", JString(uuid)))
                val data    = JObject(jFields ++ idField)
                database[JNothing.type](insert(data) into collection)
                Response[JValue](content = Some(data), headers = xDomainAjax)
              }
            }
          } ~
          path("/'id") {
            produce(application/json) {
              get { request: Request[Array[Byte]] =>
                for {
                  todo <- database(selectOne() from collection where
                    "id" === request.parameters('id)
                  )
                } yield Response[JValue](content = Some(todo.get), headers = xDomainAjax)
              } ~
              delete { request: Request[Array[Byte]] =>
                database[JNothing.type](remove from collection where
                  "id" === request.parameters('id)
                )
                Response[JValue](headers = xDomainAjax)
              } ~
              // For Ajax CORS preflight requests.
              options { request: Request[Array[Byte]] =>
                Response[JValue](headers = xDomainAjax)
              }
            } ~
            jvalue {
              put {
                refineContentType[JValue, JObject] { request: Request[JObject] =>
                  val data = request.content.get
                  database[JNothing.type](update(collection) set data where
                    "id" === request.parameters('id)
                  )
                  Response[JValue](content = Some(data), headers = xDomainAjax)
                }
              }
            }
          }
        }
      } ->
      shutdown { config: Config =>
        // Nothing to do.
      }
    }
  }
}

case class Config(config: ConfigMap, mongo: Mongo) {
  val database    = mongo.database(config.getString("mongo.db", "tododb"))
  val collection  = config.getString("mongo.collection", "todos")
  val xDomainAjax = Map(
    "Access-Control-Allow-Origin"  -> config.getString("xdomain", "http://localhost:3333"),
    "Access-Control-Allow-Methods" -> "GET, POST, PUT, DELETE",
    "Access-Control-Allow-Headers" -> "Content-Type, *",
    "Access-Control-Max-Age"       -> "3628800"
  )
}

object TodoServer extends BlueEyesServer with TodoServices {
  private lazy val injector = Guice.createInjector(
    new FilesystemConfiggyModule(ConfiggyModule.FileLoc), new RealMongoModule)
  override lazy val mongo   = injector.getInstance(classOf[Mongo])
}
