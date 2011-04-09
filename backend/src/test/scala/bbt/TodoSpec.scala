package bbt

import blueeyes.core.service.test.BlueEyesServiceSpecification
import blueeyes.core.http.{HttpResponse => Response, HttpStatus => Status}
import blueeyes.core.http.HttpStatusCodes._
import blueeyes.persistence.mongo.Mongo
import blueeyes.persistence.mongo.mock.MockMongoModule
import blueeyes.config.ConfiggyModule
import com.google.inject.Guice

class TodoSpec extends BlueEyesServiceSpecification[Array[Byte]] with TodoServices {
  private lazy val injector =
    Guice.createInjector(new ConfiggyModule(rootConfig), new MockMongoModule)

  override lazy val mongo = injector.getInstance(classOf[Mongo])
  lazy val database       = mongo.database("todotestdb")

  path$("/todos") {
    get$ { response: Response[Array[Byte]] =>
      response.status mustEqual Status(OK)
      response.content.get mustNotBe None
    }
  } should "return OK status."
}
