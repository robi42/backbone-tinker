# An example Backbone application contributed by
# [Jérôme Gravel-Niquet](http://jgn.me/). This demo has been hacked on by
# [Robert Thurnher](http://robert42.com/) and is now backed by a remote
# [BlueEyes](https://github.com/jdegoes/blueeyes)/MongoDB server.

# Load the application once the DOM is ready, using `jQuery.ready`:
$ ->

  # Finally, we kick things off by creating the **app**.
  window.app = new (require('controller').App)
  Backbone.history.saveLocation('/home') if Backbone.history.getFragment() is ''
  Backbone.history.start()
  return
